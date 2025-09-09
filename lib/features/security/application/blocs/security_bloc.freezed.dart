// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'security_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SecurityEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
    required TResult Function() checkUpdates,
    required TResult Function() retryCheck,
    required TResult Function() dismissWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
    TResult? Function()? checkUpdates,
    TResult? Function()? retryCheck,
    TResult? Function()? dismissWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    TResult Function()? checkUpdates,
    TResult Function()? retryCheck,
    TResult Function()? dismissWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckSecurityEvent value) checkSecurity,
    required TResult Function(CheckUpdatesEvent value) checkUpdates,
    required TResult Function(RetryCheckEvent value) retryCheck,
    required TResult Function(DismissWarningEvent value) dismissWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckSecurityEvent value)? checkSecurity,
    TResult? Function(CheckUpdatesEvent value)? checkUpdates,
    TResult? Function(RetryCheckEvent value)? retryCheck,
    TResult? Function(DismissWarningEvent value)? dismissWarning,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckSecurityEvent value)? checkSecurity,
    TResult Function(CheckUpdatesEvent value)? checkUpdates,
    TResult Function(RetryCheckEvent value)? retryCheck,
    TResult Function(DismissWarningEvent value)? dismissWarning,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityEventCopyWith<$Res> {
  factory $SecurityEventCopyWith(
          SecurityEvent value, $Res Function(SecurityEvent) then) =
      _$SecurityEventCopyWithImpl<$Res, SecurityEvent>;
}

/// @nodoc
class _$SecurityEventCopyWithImpl<$Res, $Val extends SecurityEvent>
    implements $SecurityEventCopyWith<$Res> {
  _$SecurityEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$CheckSecurityEventImplCopyWith<$Res> {
  factory _$$CheckSecurityEventImplCopyWith(_$CheckSecurityEventImpl value,
          $Res Function(_$CheckSecurityEventImpl) then) =
      __$$CheckSecurityEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckSecurityEventImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$CheckSecurityEventImpl>
    implements _$$CheckSecurityEventImplCopyWith<$Res> {
  __$$CheckSecurityEventImplCopyWithImpl(_$CheckSecurityEventImpl _value,
      $Res Function(_$CheckSecurityEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckSecurityEventImpl implements CheckSecurityEvent {
  const _$CheckSecurityEventImpl();

  @override
  String toString() {
    return 'SecurityEvent.checkSecurity()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckSecurityEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
    required TResult Function() checkUpdates,
    required TResult Function() retryCheck,
    required TResult Function() dismissWarning,
  }) {
    return checkSecurity();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
    TResult? Function()? checkUpdates,
    TResult? Function()? retryCheck,
    TResult? Function()? dismissWarning,
  }) {
    return checkSecurity?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    TResult Function()? checkUpdates,
    TResult Function()? retryCheck,
    TResult Function()? dismissWarning,
    required TResult orElse(),
  }) {
    if (checkSecurity != null) {
      return checkSecurity();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckSecurityEvent value) checkSecurity,
    required TResult Function(CheckUpdatesEvent value) checkUpdates,
    required TResult Function(RetryCheckEvent value) retryCheck,
    required TResult Function(DismissWarningEvent value) dismissWarning,
  }) {
    return checkSecurity(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckSecurityEvent value)? checkSecurity,
    TResult? Function(CheckUpdatesEvent value)? checkUpdates,
    TResult? Function(RetryCheckEvent value)? retryCheck,
    TResult? Function(DismissWarningEvent value)? dismissWarning,
  }) {
    return checkSecurity?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckSecurityEvent value)? checkSecurity,
    TResult Function(CheckUpdatesEvent value)? checkUpdates,
    TResult Function(RetryCheckEvent value)? retryCheck,
    TResult Function(DismissWarningEvent value)? dismissWarning,
    required TResult orElse(),
  }) {
    if (checkSecurity != null) {
      return checkSecurity(this);
    }
    return orElse();
  }
}

abstract class CheckSecurityEvent implements SecurityEvent {
  const factory CheckSecurityEvent() = _$CheckSecurityEventImpl;
}

/// @nodoc
abstract class _$$CheckUpdatesEventImplCopyWith<$Res> {
  factory _$$CheckUpdatesEventImplCopyWith(_$CheckUpdatesEventImpl value,
          $Res Function(_$CheckUpdatesEventImpl) then) =
      __$$CheckUpdatesEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CheckUpdatesEventImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$CheckUpdatesEventImpl>
    implements _$$CheckUpdatesEventImplCopyWith<$Res> {
  __$$CheckUpdatesEventImplCopyWithImpl(_$CheckUpdatesEventImpl _value,
      $Res Function(_$CheckUpdatesEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CheckUpdatesEventImpl implements CheckUpdatesEvent {
  const _$CheckUpdatesEventImpl();

  @override
  String toString() {
    return 'SecurityEvent.checkUpdates()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CheckUpdatesEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
    required TResult Function() checkUpdates,
    required TResult Function() retryCheck,
    required TResult Function() dismissWarning,
  }) {
    return checkUpdates();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
    TResult? Function()? checkUpdates,
    TResult? Function()? retryCheck,
    TResult? Function()? dismissWarning,
  }) {
    return checkUpdates?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    TResult Function()? checkUpdates,
    TResult Function()? retryCheck,
    TResult Function()? dismissWarning,
    required TResult orElse(),
  }) {
    if (checkUpdates != null) {
      return checkUpdates();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckSecurityEvent value) checkSecurity,
    required TResult Function(CheckUpdatesEvent value) checkUpdates,
    required TResult Function(RetryCheckEvent value) retryCheck,
    required TResult Function(DismissWarningEvent value) dismissWarning,
  }) {
    return checkUpdates(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckSecurityEvent value)? checkSecurity,
    TResult? Function(CheckUpdatesEvent value)? checkUpdates,
    TResult? Function(RetryCheckEvent value)? retryCheck,
    TResult? Function(DismissWarningEvent value)? dismissWarning,
  }) {
    return checkUpdates?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckSecurityEvent value)? checkSecurity,
    TResult Function(CheckUpdatesEvent value)? checkUpdates,
    TResult Function(RetryCheckEvent value)? retryCheck,
    TResult Function(DismissWarningEvent value)? dismissWarning,
    required TResult orElse(),
  }) {
    if (checkUpdates != null) {
      return checkUpdates(this);
    }
    return orElse();
  }
}

abstract class CheckUpdatesEvent implements SecurityEvent {
  const factory CheckUpdatesEvent() = _$CheckUpdatesEventImpl;
}

/// @nodoc
abstract class _$$RetryCheckEventImplCopyWith<$Res> {
  factory _$$RetryCheckEventImplCopyWith(_$RetryCheckEventImpl value,
          $Res Function(_$RetryCheckEventImpl) then) =
      __$$RetryCheckEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RetryCheckEventImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$RetryCheckEventImpl>
    implements _$$RetryCheckEventImplCopyWith<$Res> {
  __$$RetryCheckEventImplCopyWithImpl(
      _$RetryCheckEventImpl _value, $Res Function(_$RetryCheckEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$RetryCheckEventImpl implements RetryCheckEvent {
  const _$RetryCheckEventImpl();

  @override
  String toString() {
    return 'SecurityEvent.retryCheck()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RetryCheckEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
    required TResult Function() checkUpdates,
    required TResult Function() retryCheck,
    required TResult Function() dismissWarning,
  }) {
    return retryCheck();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
    TResult? Function()? checkUpdates,
    TResult? Function()? retryCheck,
    TResult? Function()? dismissWarning,
  }) {
    return retryCheck?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    TResult Function()? checkUpdates,
    TResult Function()? retryCheck,
    TResult Function()? dismissWarning,
    required TResult orElse(),
  }) {
    if (retryCheck != null) {
      return retryCheck();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckSecurityEvent value) checkSecurity,
    required TResult Function(CheckUpdatesEvent value) checkUpdates,
    required TResult Function(RetryCheckEvent value) retryCheck,
    required TResult Function(DismissWarningEvent value) dismissWarning,
  }) {
    return retryCheck(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckSecurityEvent value)? checkSecurity,
    TResult? Function(CheckUpdatesEvent value)? checkUpdates,
    TResult? Function(RetryCheckEvent value)? retryCheck,
    TResult? Function(DismissWarningEvent value)? dismissWarning,
  }) {
    return retryCheck?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckSecurityEvent value)? checkSecurity,
    TResult Function(CheckUpdatesEvent value)? checkUpdates,
    TResult Function(RetryCheckEvent value)? retryCheck,
    TResult Function(DismissWarningEvent value)? dismissWarning,
    required TResult orElse(),
  }) {
    if (retryCheck != null) {
      return retryCheck(this);
    }
    return orElse();
  }
}

abstract class RetryCheckEvent implements SecurityEvent {
  const factory RetryCheckEvent() = _$RetryCheckEventImpl;
}

/// @nodoc
abstract class _$$DismissWarningEventImplCopyWith<$Res> {
  factory _$$DismissWarningEventImplCopyWith(_$DismissWarningEventImpl value,
          $Res Function(_$DismissWarningEventImpl) then) =
      __$$DismissWarningEventImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DismissWarningEventImplCopyWithImpl<$Res>
    extends _$SecurityEventCopyWithImpl<$Res, _$DismissWarningEventImpl>
    implements _$$DismissWarningEventImplCopyWith<$Res> {
  __$$DismissWarningEventImplCopyWithImpl(_$DismissWarningEventImpl _value,
      $Res Function(_$DismissWarningEventImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityEvent
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DismissWarningEventImpl implements DismissWarningEvent {
  const _$DismissWarningEventImpl();

  @override
  String toString() {
    return 'SecurityEvent.dismissWarning()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DismissWarningEventImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() checkSecurity,
    required TResult Function() checkUpdates,
    required TResult Function() retryCheck,
    required TResult Function() dismissWarning,
  }) {
    return dismissWarning();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? checkSecurity,
    TResult? Function()? checkUpdates,
    TResult? Function()? retryCheck,
    TResult? Function()? dismissWarning,
  }) {
    return dismissWarning?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? checkSecurity,
    TResult Function()? checkUpdates,
    TResult Function()? retryCheck,
    TResult Function()? dismissWarning,
    required TResult orElse(),
  }) {
    if (dismissWarning != null) {
      return dismissWarning();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(CheckSecurityEvent value) checkSecurity,
    required TResult Function(CheckUpdatesEvent value) checkUpdates,
    required TResult Function(RetryCheckEvent value) retryCheck,
    required TResult Function(DismissWarningEvent value) dismissWarning,
  }) {
    return dismissWarning(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(CheckSecurityEvent value)? checkSecurity,
    TResult? Function(CheckUpdatesEvent value)? checkUpdates,
    TResult? Function(RetryCheckEvent value)? retryCheck,
    TResult? Function(DismissWarningEvent value)? dismissWarning,
  }) {
    return dismissWarning?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(CheckSecurityEvent value)? checkSecurity,
    TResult Function(CheckUpdatesEvent value)? checkUpdates,
    TResult Function(RetryCheckEvent value)? retryCheck,
    TResult Function(DismissWarningEvent value)? dismissWarning,
    required TResult orElse(),
  }) {
    if (dismissWarning != null) {
      return dismissWarning(this);
    }
    return orElse();
  }
}

abstract class DismissWarningEvent implements SecurityEvent {
  const factory DismissWarningEvent() = _$DismissWarningEventImpl;
}

/// @nodoc
mixin _$SecurityState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) criticalFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? criticalFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? criticalFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SecurityInitial value) initial,
    required TResult Function(SecurityLoading value) loading,
    required TResult Function(SecurityLoaded value) loaded,
    required TResult Function(SecurityError value) error,
    required TResult Function(SecurityCriticalFailure value) criticalFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SecurityInitial value)? initial,
    TResult? Function(SecurityLoading value)? loading,
    TResult? Function(SecurityLoaded value)? loaded,
    TResult? Function(SecurityError value)? error,
    TResult? Function(SecurityCriticalFailure value)? criticalFailure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SecurityInitial value)? initial,
    TResult Function(SecurityLoading value)? loading,
    TResult Function(SecurityLoaded value)? loaded,
    TResult Function(SecurityError value)? error,
    TResult Function(SecurityCriticalFailure value)? criticalFailure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SecurityStateCopyWith<$Res> {
  factory $SecurityStateCopyWith(
          SecurityState value, $Res Function(SecurityState) then) =
      _$SecurityStateCopyWithImpl<$Res, SecurityState>;
}

/// @nodoc
class _$SecurityStateCopyWithImpl<$Res, $Val extends SecurityState>
    implements $SecurityStateCopyWith<$Res> {
  _$SecurityStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$SecurityInitialImplCopyWith<$Res> {
  factory _$$SecurityInitialImplCopyWith(_$SecurityInitialImpl value,
          $Res Function(_$SecurityInitialImpl) then) =
      __$$SecurityInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SecurityInitialImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$SecurityInitialImpl>
    implements _$$SecurityInitialImplCopyWith<$Res> {
  __$$SecurityInitialImplCopyWithImpl(
      _$SecurityInitialImpl _value, $Res Function(_$SecurityInitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SecurityInitialImpl implements SecurityInitial {
  const _$SecurityInitialImpl();

  @override
  String toString() {
    return 'SecurityState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SecurityInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) criticalFailure,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? criticalFailure,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? criticalFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SecurityInitial value) initial,
    required TResult Function(SecurityLoading value) loading,
    required TResult Function(SecurityLoaded value) loaded,
    required TResult Function(SecurityError value) error,
    required TResult Function(SecurityCriticalFailure value) criticalFailure,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SecurityInitial value)? initial,
    TResult? Function(SecurityLoading value)? loading,
    TResult? Function(SecurityLoaded value)? loaded,
    TResult? Function(SecurityError value)? error,
    TResult? Function(SecurityCriticalFailure value)? criticalFailure,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SecurityInitial value)? initial,
    TResult Function(SecurityLoading value)? loading,
    TResult Function(SecurityLoaded value)? loaded,
    TResult Function(SecurityError value)? error,
    TResult Function(SecurityCriticalFailure value)? criticalFailure,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class SecurityInitial implements SecurityState {
  const factory SecurityInitial() = _$SecurityInitialImpl;
}

/// @nodoc
abstract class _$$SecurityLoadingImplCopyWith<$Res> {
  factory _$$SecurityLoadingImplCopyWith(_$SecurityLoadingImpl value,
          $Res Function(_$SecurityLoadingImpl) then) =
      __$$SecurityLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SecurityLoadingImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$SecurityLoadingImpl>
    implements _$$SecurityLoadingImplCopyWith<$Res> {
  __$$SecurityLoadingImplCopyWithImpl(
      _$SecurityLoadingImpl _value, $Res Function(_$SecurityLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SecurityLoadingImpl implements SecurityLoading {
  const _$SecurityLoadingImpl();

  @override
  String toString() {
    return 'SecurityState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$SecurityLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) criticalFailure,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? criticalFailure,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? criticalFailure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SecurityInitial value) initial,
    required TResult Function(SecurityLoading value) loading,
    required TResult Function(SecurityLoaded value) loaded,
    required TResult Function(SecurityError value) error,
    required TResult Function(SecurityCriticalFailure value) criticalFailure,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SecurityInitial value)? initial,
    TResult? Function(SecurityLoading value)? loading,
    TResult? Function(SecurityLoaded value)? loaded,
    TResult? Function(SecurityError value)? error,
    TResult? Function(SecurityCriticalFailure value)? criticalFailure,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SecurityInitial value)? initial,
    TResult Function(SecurityLoading value)? loading,
    TResult Function(SecurityLoaded value)? loaded,
    TResult Function(SecurityError value)? error,
    TResult Function(SecurityCriticalFailure value)? criticalFailure,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class SecurityLoading implements SecurityState {
  const factory SecurityLoading() = _$SecurityLoadingImpl;
}

/// @nodoc
abstract class _$$SecurityLoadedImplCopyWith<$Res> {
  factory _$$SecurityLoadedImplCopyWith(_$SecurityLoadedImpl value,
          $Res Function(_$SecurityLoadedImpl) then) =
      __$$SecurityLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {SecurityAssessment securityAssessment,
      AppUpdatePolicy updatePolicy,
      bool warningDismissed,
      bool isCheckingUpdates,
      String? updateError});
}

/// @nodoc
class __$$SecurityLoadedImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$SecurityLoadedImpl>
    implements _$$SecurityLoadedImplCopyWith<$Res> {
  __$$SecurityLoadedImplCopyWithImpl(
      _$SecurityLoadedImpl _value, $Res Function(_$SecurityLoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? securityAssessment = null,
    Object? updatePolicy = null,
    Object? warningDismissed = null,
    Object? isCheckingUpdates = null,
    Object? updateError = freezed,
  }) {
    return _then(_$SecurityLoadedImpl(
      securityAssessment: null == securityAssessment
          ? _value.securityAssessment
          : securityAssessment // ignore: cast_nullable_to_non_nullable
              as SecurityAssessment,
      updatePolicy: null == updatePolicy
          ? _value.updatePolicy
          : updatePolicy // ignore: cast_nullable_to_non_nullable
              as AppUpdatePolicy,
      warningDismissed: null == warningDismissed
          ? _value.warningDismissed
          : warningDismissed // ignore: cast_nullable_to_non_nullable
              as bool,
      isCheckingUpdates: null == isCheckingUpdates
          ? _value.isCheckingUpdates
          : isCheckingUpdates // ignore: cast_nullable_to_non_nullable
              as bool,
      updateError: freezed == updateError
          ? _value.updateError
          : updateError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SecurityLoadedImpl implements SecurityLoaded {
  const _$SecurityLoadedImpl(
      {required this.securityAssessment,
      required this.updatePolicy,
      this.warningDismissed = false,
      this.isCheckingUpdates = false,
      this.updateError});

  @override
  final SecurityAssessment securityAssessment;
  @override
  final AppUpdatePolicy updatePolicy;
  @override
  @JsonKey()
  final bool warningDismissed;
  @override
  @JsonKey()
  final bool isCheckingUpdates;
  @override
  final String? updateError;

  @override
  String toString() {
    return 'SecurityState.loaded(securityAssessment: $securityAssessment, updatePolicy: $updatePolicy, warningDismissed: $warningDismissed, isCheckingUpdates: $isCheckingUpdates, updateError: $updateError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityLoadedImpl &&
            (identical(other.securityAssessment, securityAssessment) ||
                other.securityAssessment == securityAssessment) &&
            (identical(other.updatePolicy, updatePolicy) ||
                other.updatePolicy == updatePolicy) &&
            (identical(other.warningDismissed, warningDismissed) ||
                other.warningDismissed == warningDismissed) &&
            (identical(other.isCheckingUpdates, isCheckingUpdates) ||
                other.isCheckingUpdates == isCheckingUpdates) &&
            (identical(other.updateError, updateError) ||
                other.updateError == updateError));
  }

  @override
  int get hashCode => Object.hash(runtimeType, securityAssessment, updatePolicy,
      warningDismissed, isCheckingUpdates, updateError);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityLoadedImplCopyWith<_$SecurityLoadedImpl> get copyWith =>
      __$$SecurityLoadedImplCopyWithImpl<_$SecurityLoadedImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) criticalFailure,
  }) {
    return loaded(securityAssessment, updatePolicy, warningDismissed,
        isCheckingUpdates, updateError);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? criticalFailure,
  }) {
    return loaded?.call(securityAssessment, updatePolicy, warningDismissed,
        isCheckingUpdates, updateError);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? criticalFailure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(securityAssessment, updatePolicy, warningDismissed,
          isCheckingUpdates, updateError);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SecurityInitial value) initial,
    required TResult Function(SecurityLoading value) loading,
    required TResult Function(SecurityLoaded value) loaded,
    required TResult Function(SecurityError value) error,
    required TResult Function(SecurityCriticalFailure value) criticalFailure,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SecurityInitial value)? initial,
    TResult? Function(SecurityLoading value)? loading,
    TResult? Function(SecurityLoaded value)? loaded,
    TResult? Function(SecurityError value)? error,
    TResult? Function(SecurityCriticalFailure value)? criticalFailure,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SecurityInitial value)? initial,
    TResult Function(SecurityLoading value)? loading,
    TResult Function(SecurityLoaded value)? loaded,
    TResult Function(SecurityError value)? error,
    TResult Function(SecurityCriticalFailure value)? criticalFailure,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class SecurityLoaded implements SecurityState {
  const factory SecurityLoaded(
      {required final SecurityAssessment securityAssessment,
      required final AppUpdatePolicy updatePolicy,
      final bool warningDismissed,
      final bool isCheckingUpdates,
      final String? updateError}) = _$SecurityLoadedImpl;

  SecurityAssessment get securityAssessment;
  AppUpdatePolicy get updatePolicy;
  bool get warningDismissed;
  bool get isCheckingUpdates;
  String? get updateError;

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityLoadedImplCopyWith<_$SecurityLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SecurityErrorImplCopyWith<$Res> {
  factory _$$SecurityErrorImplCopyWith(
          _$SecurityErrorImpl value, $Res Function(_$SecurityErrorImpl) then) =
      __$$SecurityErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SecurityErrorImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$SecurityErrorImpl>
    implements _$$SecurityErrorImplCopyWith<$Res> {
  __$$SecurityErrorImplCopyWithImpl(
      _$SecurityErrorImpl _value, $Res Function(_$SecurityErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SecurityErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SecurityErrorImpl implements SecurityError {
  const _$SecurityErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SecurityState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityErrorImplCopyWith<_$SecurityErrorImpl> get copyWith =>
      __$$SecurityErrorImplCopyWithImpl<_$SecurityErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) criticalFailure,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? criticalFailure,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? criticalFailure,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SecurityInitial value) initial,
    required TResult Function(SecurityLoading value) loading,
    required TResult Function(SecurityLoaded value) loaded,
    required TResult Function(SecurityError value) error,
    required TResult Function(SecurityCriticalFailure value) criticalFailure,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SecurityInitial value)? initial,
    TResult? Function(SecurityLoading value)? loading,
    TResult? Function(SecurityLoaded value)? loaded,
    TResult? Function(SecurityError value)? error,
    TResult? Function(SecurityCriticalFailure value)? criticalFailure,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SecurityInitial value)? initial,
    TResult Function(SecurityLoading value)? loading,
    TResult Function(SecurityLoaded value)? loaded,
    TResult Function(SecurityError value)? error,
    TResult Function(SecurityCriticalFailure value)? criticalFailure,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class SecurityError implements SecurityState {
  const factory SecurityError(final String message) = _$SecurityErrorImpl;

  String get message;

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityErrorImplCopyWith<_$SecurityErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$SecurityCriticalFailureImplCopyWith<$Res> {
  factory _$$SecurityCriticalFailureImplCopyWith(
          _$SecurityCriticalFailureImpl value,
          $Res Function(_$SecurityCriticalFailureImpl) then) =
      __$$SecurityCriticalFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$SecurityCriticalFailureImplCopyWithImpl<$Res>
    extends _$SecurityStateCopyWithImpl<$Res, _$SecurityCriticalFailureImpl>
    implements _$$SecurityCriticalFailureImplCopyWith<$Res> {
  __$$SecurityCriticalFailureImplCopyWithImpl(
      _$SecurityCriticalFailureImpl _value,
      $Res Function(_$SecurityCriticalFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$SecurityCriticalFailureImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SecurityCriticalFailureImpl implements SecurityCriticalFailure {
  const _$SecurityCriticalFailureImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'SecurityState.criticalFailure(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SecurityCriticalFailureImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SecurityCriticalFailureImplCopyWith<_$SecurityCriticalFailureImpl>
      get copyWith => __$$SecurityCriticalFailureImplCopyWithImpl<
          _$SecurityCriticalFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)
        loaded,
    required TResult Function(String message) error,
    required TResult Function(String message) criticalFailure,
  }) {
    return criticalFailure(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult? Function(String message)? error,
    TResult? Function(String message)? criticalFailure,
  }) {
    return criticalFailure?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            SecurityAssessment securityAssessment,
            AppUpdatePolicy updatePolicy,
            bool warningDismissed,
            bool isCheckingUpdates,
            String? updateError)?
        loaded,
    TResult Function(String message)? error,
    TResult Function(String message)? criticalFailure,
    required TResult orElse(),
  }) {
    if (criticalFailure != null) {
      return criticalFailure(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(SecurityInitial value) initial,
    required TResult Function(SecurityLoading value) loading,
    required TResult Function(SecurityLoaded value) loaded,
    required TResult Function(SecurityError value) error,
    required TResult Function(SecurityCriticalFailure value) criticalFailure,
  }) {
    return criticalFailure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(SecurityInitial value)? initial,
    TResult? Function(SecurityLoading value)? loading,
    TResult? Function(SecurityLoaded value)? loaded,
    TResult? Function(SecurityError value)? error,
    TResult? Function(SecurityCriticalFailure value)? criticalFailure,
  }) {
    return criticalFailure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(SecurityInitial value)? initial,
    TResult Function(SecurityLoading value)? loading,
    TResult Function(SecurityLoaded value)? loaded,
    TResult Function(SecurityError value)? error,
    TResult Function(SecurityCriticalFailure value)? criticalFailure,
    required TResult orElse(),
  }) {
    if (criticalFailure != null) {
      return criticalFailure(this);
    }
    return orElse();
  }
}

abstract class SecurityCriticalFailure implements SecurityState {
  const factory SecurityCriticalFailure(final String message) =
      _$SecurityCriticalFailureImpl;

  String get message;

  /// Create a copy of SecurityState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SecurityCriticalFailureImplCopyWith<_$SecurityCriticalFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
