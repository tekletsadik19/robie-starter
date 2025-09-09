part of 'security_bloc.dart';

@freezed
abstract class SecurityState with _$SecurityState {
  const factory SecurityState.initial() = SecurityInitial;
  const factory SecurityState.loading() = SecurityLoading;
  const factory SecurityState.loaded({
    required SecurityAssessment securityAssessment,
    required AppUpdatePolicy updatePolicy,
    @Default(false) bool warningDismissed,
    @Default(false) bool isCheckingUpdates,
    String? updateError,
  }) = SecurityLoaded;
  const factory SecurityState.error(String message) = SecurityError;
  const factory SecurityState.criticalFailure(String message) =
      SecurityCriticalFailure;
}
