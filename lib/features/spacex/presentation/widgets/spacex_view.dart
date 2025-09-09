import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';
import 'package:robbie_starter/features/spacex/application/blocs/spacex_bloc.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';
import 'package:robbie_starter/features/spacex/presentation/widgets/launch_card.dart';
import 'package:robbie_starter/features/spacex/presentation/widgets/latest_launch_hero.dart';
import 'package:robbie_starter/features/spacex/presentation/widgets/spacex_error_widget.dart';
import 'package:robbie_starter/features/spacex/presentation/widgets/spacex_loading_widget.dart';

/// Main view for SpaceX data
class SpaceXView extends StatelessWidget {
  const SpaceXView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpaceX Launches'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        actions: [
          BlocBuilder<SpaceXBloc, SpaceXState>(
            builder: (context, state) {
              return IconButton(
                onPressed: state.isLoading
                    ? null
                    : () => context.read<SpaceXBloc>().add(
                          const SpaceXEvent.refreshData(),
                        ),
                icon: state.isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.refresh),
                tooltip: 'Refresh',
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SpaceXBloc, SpaceXState>(
        builder: (context, state) {
          if (state.isLoading && !state.hasAllDataLoaded) {
            return const SpaceXLoadingWidget();
          }

          if (state.hasError && !state.hasAllDataLoaded) {
            return SpaceXErrorWidget(
              message: state.errorMessage ?? 'An error occurred',
              onRetry: () => context.read<SpaceXBloc>().add(
                    const SpaceXEvent.loadAllData(),
                  ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<SpaceXBloc>().add(const SpaceXEvent.refreshData());
              // Wait for refresh to complete
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.all(ResponsiveUtils.padding(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Latest Launch Hero Section
                  if (state.latestLaunch != null) ...[
                    LatestLaunchHero(launch: state.latestLaunch!),
                    SizedBox(height: ResponsiveUtils.spacing(context) * 2),
                  ],

                  // Upcoming Launches Section
                  if (state.upcomingLaunches.isNotEmpty) ...[
                    _buildSectionHeader(
                      context,
                      'Upcoming Launches',
                      Icons.rocket_launch,
                    ),
                    SizedBox(height: ResponsiveUtils.spacing(context)),
                    _buildLaunchList(
                      context,
                      state.nextLaunches,
                      isUpcoming: true,
                    ),
                    SizedBox(height: ResponsiveUtils.spacing(context) * 2),
                  ],

                  // Recent Launches Section
                  if (state.pastLaunches.isNotEmpty) ...[
                    _buildSectionHeader(
                      context,
                      'Recent Launches',
                      Icons.history,
                    ),
                    SizedBox(height: ResponsiveUtils.spacing(context)),
                    _buildLaunchList(context, state.recentLaunches),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          color: Theme.of(context).colorScheme.primary,
          size: 24,
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ],
    );
  }

  Widget _buildLaunchList(
    BuildContext context,
    List<LaunchEntity> launches, {
    bool isUpcoming = false,
  }) {
    return Column(
      children: launches
          .map(
            (launch) => Padding(
              padding: EdgeInsets.only(
                bottom: ResponsiveUtils.spacing(context),
              ),
              child: LaunchCard(
                launch: launch,
                isUpcoming: isUpcoming,
              ),
            ),
          )
          .toList(),
    );
  }
}
