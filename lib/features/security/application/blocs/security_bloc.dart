import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:robbie_starter/features/security/domain/aggregates/app_update_policy.dart';
import 'package:robbie_starter/features/security/domain/aggregates/security_assessment.dart';
import 'package:robbie_starter/shared/application/use_cases/base_use_case.dart';
import 'package:robbie_starter/features/security/domain/usecases/check_security_status.dart';
import 'package:robbie_starter/features/security/domain/usecases/check_for_updates.dart';

part 'security_event.dart';
part 'security_state.dart';
part 'security_bloc.freezed.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {
  SecurityBloc({
    required PerformSecurityAssessment performSecurityAssessment,
    required EvaluateUpdatePolicy evaluateUpdatePolicy,
  })  : _performSecurityAssessment = performSecurityAssessment,
        _evaluateUpdatePolicy = evaluateUpdatePolicy,
        super(const SecurityState.initial()) {
    on<CheckSecurityEvent>((event, emit) => _onCheckSecurity(emit));
    on<CheckUpdatesEvent>((event, emit) => _onCheckUpdates(emit));
    on<DismissWarningEvent>((event, emit) => _onDismissWarning(emit));
    on<RetryCheckEvent>((event, emit) => _onRetryCheck(emit));
  }

  final PerformSecurityAssessment _performSecurityAssessment;
  final EvaluateUpdatePolicy _evaluateUpdatePolicy;

  Future<void> _onCheckSecurity(Emitter<SecurityState> emit) async {
    emit(const SecurityState.loading());

    final securityResult = await _performSecurityAssessment(const NoParams());
    final updateResult = await _evaluateUpdatePolicy(const NoParams());

    securityResult.fold(
      (failure) {
        // For critical security failures, emit a specific error state
        if (failure.message?.contains('CRITICAL SECURITY FAILURE') == true) {
          emit(
            SecurityState.criticalFailure(
              failure.message ?? 'Unknown error',
            ),
          );
        } else {
          emit(SecurityState.error(failure.message ?? 'Unknown error'));
        }
      },
      (securityAssessment) {
        updateResult.fold(
          (failure) =>
              emit(SecurityState.error(failure.message ?? 'Unknown error')),
          (updatePolicy) => emit(
            SecurityState.loaded(
              securityAssessment: securityAssessment,
              updatePolicy: updatePolicy,
            ),
          ),
        );
      },
    );
  }

  Future<void> _onCheckUpdates(Emitter<SecurityState> emit) async {
    state.maybeWhen(
      loaded:
          (securityAssessment, updatePolicy, warningDismissed, _, updateError) {
        emit(
          SecurityState.loaded(
            securityAssessment: securityAssessment,
            updatePolicy: updatePolicy,
            warningDismissed: warningDismissed,
            isCheckingUpdates: true,
            updateError: updateError,
          ),
        );
      },
      orElse: () => null,
    );

    final result = await _evaluateUpdatePolicy(const NoParams());

    state.maybeWhen(
      loaded: (
        securityAssessment,
        oldUpdatePolicy,
        warningDismissed,
        isCheckingUpdates,
        updateError,
      ) {
        result.fold(
          (failure) => emit(
            SecurityState.loaded(
              securityAssessment: securityAssessment,
              updatePolicy: oldUpdatePolicy,
              warningDismissed: warningDismissed,
              updateError: failure.message ?? 'Unknown error',
            ),
          ),
          (updatePolicy) => emit(
            SecurityState.loaded(
              securityAssessment: securityAssessment,
              updatePolicy: updatePolicy,
              warningDismissed: warningDismissed,
            ),
          ),
        );
      },
      orElse: () => null,
    );
  }

  void _onDismissWarning(Emitter<SecurityState> emit) {
    state.maybeWhen(
      loaded: (
        securityAssessment,
        updatePolicy,
        _,
        isCheckingUpdates,
        updateError,
      ) {
        emit(
          SecurityState.loaded(
            securityAssessment: securityAssessment,
            updatePolicy: updatePolicy,
            warningDismissed: true,
            isCheckingUpdates: isCheckingUpdates,
            updateError: updateError,
          ),
        );
      },
      orElse: () => null,
    );
  }

  void _onRetryCheck(Emitter<SecurityState> emit) {
    add(const SecurityEvent.checkSecurity());
  }
}
