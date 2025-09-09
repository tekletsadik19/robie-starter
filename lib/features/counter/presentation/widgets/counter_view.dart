import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:robbie_starter/features/counter/domain/entities/counter_entity.dart';
import 'package:robbie_starter/features/counter/presentation/cubits/counter_cubit.dart';

/// Main counter view body
class CounterBody extends StatelessWidget {
  const CounterBody({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) => state.when(
          initial: () => const Center(
            child: Text('Initializing...'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          loaded: (counter) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Current Count:',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                Text(
                  '${counter.value}',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _getCounterColor(counter.value),
                      ),
                ),
                const SizedBox(height: 24),
                CounterStats(counter: counter),
              ],
            ),
          ),
          error: (message) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Error: $message',
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<CounterCubit>().loadCounter(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      );

  Color? _getCounterColor(int value) {
    if (value > 0) return Colors.green;
    if (value < 0) return Colors.red;
    return null;
  }
}

/// Counter statistics widget
class CounterStats extends StatelessWidget {
  const CounterStats({required this.counter, super.key});

  final CounterEntity counter;

  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Counter Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text('ID: ${counter.id}'),
              Text('Created: ${_formatDateTime(counter.createdAt)}'),
              if (counter.updatedAt != null)
                Text('Last Updated: ${_formatDateTime(counter.updatedAt!)}'),
            ],
          ),
        ),
      );

  String _formatDateTime(DateTime dateTime) =>
      '${dateTime.day}/${dateTime.month}/${dateTime.year} '
      '${dateTime.hour.toString().padLeft(2, '0')}:'
      '${dateTime.minute.toString().padLeft(2, '0')}';
}

/// Floating action buttons for counter operations
class CounterFloatingActionButtons extends StatelessWidget {
  const CounterFloatingActionButtons({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<CounterCubit, CounterState>(
        builder: (context, state) {
          final isLoading = state is CounterLoading;

          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: isLoading
                    ? null
                    : () => context.read<CounterCubit>().increment(),
                heroTag: 'increment',
                child: const Icon(Icons.add),
              ),
              const SizedBox(height: 8),
              FloatingActionButton(
                onPressed: isLoading
                    ? null
                    : () => context.read<CounterCubit>().decrement(),
                heroTag: 'decrement',
                child: const Icon(Icons.remove),
              ),
            ],
          );
        },
      );
}
