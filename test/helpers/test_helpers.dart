import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robbie_starter/features/counter/domain/entities/counter_entity.dart';
import 'package:robbie_starter/features/counter/infrastructure/models/counter_model.dart';
import 'package:robbie_starter/features/counter/presentation/cubits/counter_cubit.dart';

/// Test helper utilities
class TestHelpers {
  /// Create a test widget with BLoC provider
  static Widget createTestWidget({
    required Widget child,
    CounterCubit? counterCubit,
  }) =>
      MaterialApp(
        home: BlocProvider<CounterCubit>.value(
          value: counterCubit ?? MockCounterCubit(),
          child: child,
        ),
      );

  /// Pump and settle widget
  static Future<void> pumpAndSettle(
    WidgetTester tester,
    Widget widget, {
    Duration? duration,
  }) async {
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle(duration ?? const Duration(milliseconds: 100));
  }
}

/// Mock classes for testing
class MockCounterCubit extends MockCubit<CounterState>
    implements CounterCubit {}

/// Test data factories
class TestDataFactory {
  static const String defaultCounterId = 'test-counter-id';

  /// Create test counter entity
  static CounterEntity createCounterEntity({
    String? id,
    int? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CounterEntity(
        id: id ?? defaultCounterId,
        value: value ?? 0,
        createdAt: createdAt ?? DateTime(2024),
        updatedAt: updatedAt,
      );

  /// Create test counter model
  static CounterModel createCounterModel({
    String? id,
    int? value,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CounterModel(
        id: id ?? defaultCounterId,
        value: value ?? 0,
        createdAt: createdAt ?? DateTime(2024),
        updatedAt: updatedAt,
      );
}
