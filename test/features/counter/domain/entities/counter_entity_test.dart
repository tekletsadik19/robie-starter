import 'package:flutter_test/flutter_test.dart';
import 'package:shemanit/features/counter/domain/entities/counter_entity.dart';

void main() {
  group('CounterEntity', () {
    late CounterEntity counterEntity;
    late DateTime createdAt;

    setUp(() {
      createdAt = DateTime(2024);
      counterEntity = CounterEntity(
        id: 'test-id',
        value: 5,
        createdAt: createdAt,
      );
    });

    group('increment', () {
      test('should return new entity with incremented value', () {
        // Act
        final result = counterEntity.increment();

        // Assert
        expect(result.value, equals(6));
        expect(result.id, equals(counterEntity.id));
        expect(result.createdAt, equals(counterEntity.createdAt));
        expect(result.updatedAt, isNotNull);
      });

      test('should not modify original entity', () {
        // Act
        counterEntity.increment();

        // Assert
        expect(counterEntity.value, equals(5));
        expect(counterEntity.updatedAt, isNull);
      });
    });

    group('decrement', () {
      test('should return new entity with decremented value', () {
        // Act
        final result = counterEntity.decrement();

        // Assert
        expect(result.value, equals(4));
        expect(result.id, equals(counterEntity.id));
        expect(result.createdAt, equals(counterEntity.createdAt));
        expect(result.updatedAt, isNotNull);
      });

      test('should handle negative values', () {
        // Arrange
        final zeroCounter = CounterEntity(
          id: 'test-id',
          value: 0,
          createdAt: createdAt,
        );

        // Act
        final result = zeroCounter.decrement();

        // Assert
        expect(result.value, equals(-1));
      });
    });

    group('reset', () {
      test('should return new entity with zero value', () {
        // Act
        final result = counterEntity.reset();

        // Assert
        expect(result.value, equals(0));
        expect(result.id, equals(counterEntity.id));
        expect(result.createdAt, equals(counterEntity.createdAt));
        expect(result.updatedAt, isNotNull);
      });
    });

    group('equality', () {
      test('should be equal when all properties are the same', () {
        // Arrange
        final other = CounterEntity(
          id: 'test-id',
          value: 5,
          createdAt: createdAt,
        );

        // Assert
        expect(counterEntity, equals(other));
      });

      test('should not be equal when values differ', () {
        // Arrange
        final other = CounterEntity(
          id: 'test-id',
          value: 6,
          createdAt: createdAt,
        );

        // Assert
        expect(counterEntity, isNot(equals(other)));
      });
    });
  });
}
