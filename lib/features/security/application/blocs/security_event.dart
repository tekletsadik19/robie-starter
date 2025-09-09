part of 'security_bloc.dart';

@freezed
abstract class SecurityEvent with _$SecurityEvent {
  const factory SecurityEvent.checkSecurity() = CheckSecurityEvent;
  const factory SecurityEvent.checkUpdates() = CheckUpdatesEvent;
  const factory SecurityEvent.retryCheck() = RetryCheckEvent;
  const factory SecurityEvent.dismissWarning() = DismissWarningEvent;
}
