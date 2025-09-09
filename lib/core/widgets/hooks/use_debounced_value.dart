import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Hook for debouncing values
T useDebounced<T>(T value, Duration delay) {
  final debouncedValue = useState(value);
  final timer = useRef<Timer?>(null);

  useEffect(
    () {
      timer.value?.cancel();
      timer.value = Timer(delay, () {
        debouncedValue.value = value;
      });

      return () => timer.value?.cancel();
    },
    [value, delay],
  );

  useEffect(
    () {
      return () => timer.value?.cancel();
    },
    [],
  );

  return debouncedValue.value;
}

/// Hook for throttling values
T useThrottled<T>(T value, Duration duration) {
  final throttledValue = useState(value);
  final lastExecuted = useRef<DateTime?>(null);

  useEffect(
    () {
      final now = DateTime.now();
      final lastExec = lastExecuted.value;

      if (lastExec == null || now.difference(lastExec) >= duration) {
        throttledValue.value = value;
        lastExecuted.value = now;
      } else {
        final timer = Timer(
          duration - now.difference(lastExec),
          () {
            throttledValue.value = value;
            lastExecuted.value = DateTime.now();
          },
        );

        return timer.cancel;
      }

      return null;
    },
    [value],
  );

  return throttledValue.value;
}

/// Hook for managing async operations
AsyncSnapshot<T> useAsync<T>(
  Future<T> Function() future, [
  List<Object?> keys = const [],
]) {
  final snapshot = useState<AsyncSnapshot<T>>(const AsyncSnapshot.waiting());

  useEffect(
    () {
      snapshot.value = const AsyncSnapshot.waiting();

      future().then((data) {
        snapshot.value = AsyncSnapshot.withData(ConnectionState.done, data);
      }).catchError((Object error, StackTrace stackTrace) {
        snapshot.value =
            AsyncSnapshot.withError(ConnectionState.done, error, stackTrace);
      });

      return null;
    },
    keys,
  );

  return snapshot.value;
}

/// Hook for managing periodic operations
void usePeriodic(
  Duration duration,
  VoidCallback callback, [
  List<Object?> keys = const [],
]) {
  useEffect(
    () {
      final timer = Timer.periodic(duration, (_) => callback());
      return timer.cancel;
    },
    keys,
  );
}

/// Hook for managing countdown timer
Duration useCountdown(
  Duration initialDuration, {
  Duration interval = const Duration(seconds: 1),
}) {
  final remaining = useState(initialDuration);
  final isActive = useState(false);

  useEffect(
    () {
      if (!isActive.value || remaining.value <= Duration.zero) return null;

      final timer = Timer.periodic(interval, (_) {
        final newRemaining = remaining.value - interval;
        if (newRemaining <= Duration.zero) {
          remaining.value = Duration.zero;
          isActive.value = false;
        } else {
          remaining.value = newRemaining;
        }
      });

      return timer.cancel;
    },
    [isActive.value],
  );

  // Return control functions via a custom object if needed
  // For now, just return the remaining time
  return remaining.value;
}

/// Hook for managing boolean toggle state
({bool value, void Function() toggle, void Function(bool) setValue})
    useBooleanToggle([bool initialValue = false]) {
  final state = useState(initialValue);

  final toggle = useCallback(
    () {
      state.value = !state.value;
    },
    [],
  );

  final setValue = useCallback(
    (bool value) {
      state.value = value;
    },
    [],
  );

  return (
    value: state.value,
    toggle: toggle,
    setValue: setValue,
  );
}

/// Hook for managing form validation
({
  bool isValid,
  Map<String, String?> errors,
  void Function(String, String?) setError,
  void Function() clearErrors
}) useFormValidation() {
  final errors = useState<Map<String, String?>>({});

  final setError = useCallback(
    (String field, String? error) {
      final newErrors = Map<String, String?>.from(errors.value);
      if (error == null) {
        newErrors.remove(field);
      } else {
        newErrors[field] = error;
      }
      errors.value = newErrors;
    },
    [],
  );

  final clearErrors = useCallback(
    () {
      errors.value = {};
    },
    [],
  );

  final isValid = useMemoized(
    () {
      return errors.value.values.every((error) => error == null);
    },
    [errors.value],
  );

  return (
    isValid: isValid,
    errors: errors.value,
    setError: setError,
    clearErrors: clearErrors,
  );
}

/// Hook for managing previous value
T? usePrevious<T>(T value) {
  final ref = useRef<T?>(null);

  useEffect(() {
    ref.value = value;
    return null;
  });

  return ref.value;
}

/// Hook for managing local storage
({
  T? value,
  void Function(T) setValue,
  void Function() removeValue,
  bool isLoading
}) useLocalStorage<T>(
  String key,
  T Function() fromJson,
  dynamic Function(T) toJson,
) {
  final value = useState<T?>(null);
  final isLoading = useState(true);

  useEffect(
    () {
      // Load initial value from storage
      // This would integrate with your cache service
      isLoading.value = false;
      return null;
    },
    [key],
  );

  final setValue = useCallback(
    (T newValue) {
      value.value = newValue;
      // Save to storage
    },
    [],
  );

  final removeValue = useCallback(
    () {
      value.value = null;
      // Remove from storage
    },
    [],
  );

  return (
    value: value.value,
    setValue: setValue,
    removeValue: removeValue,
    isLoading: isLoading.value,
  );
}

/// Hook for managing window size
Size useWindowSize() {
  final size = useState(Size.zero);

  useEffect(
    () {
      void updateSize() {
        final window = WidgetsBinding.instance.platformDispatcher.views.first;
        size.value = window.physicalSize / window.devicePixelRatio;
      }

      updateSize();

      // In a real implementation, you'd listen to window resize events
      return null;
    },
    [],
  );

  return size.value;
}

/// Hook for managing media query
MediaQueryData useMediaQuery() {
  final context = useContext();
  return MediaQuery.of(context);
}

/// Hook for managing focus
FocusNode useFocusNode() {
  return useMemoized(FocusNode.new);
}

/// Hook for managing text editing controller with validation
({TextEditingController controller, String? error, bool isValid})
    useValidatedTextController({
  String? initialText,
  String? Function(String)? validator,
}) {
  final controller = useTextEditingController(text: initialText);
  final error = useState<String?>(null);

  useEffect(
    () {
      void validate() {
        if (validator != null) {
          error.value = validator(controller.text);
        }
      }

      controller.addListener(validate);
      return () => controller.removeListener(validate);
    },
    [validator],
  );

  final isValid = useMemoized(() => error.value == null, [error.value]);

  return (
    controller: controller,
    error: error.value,
    isValid: isValid,
  );
}
