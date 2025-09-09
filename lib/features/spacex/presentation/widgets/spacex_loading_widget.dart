import 'package:flutter/material.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';

/// Loading widget for SpaceX data
class SpaceXLoadingWidget extends StatelessWidget {
  const SpaceXLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.all(ResponsiveUtils.padding(context)),
      child: Column(
        children: [
          // Hero Section Shimmer
          _buildShimmerContainer(
            height: 200,
            borderRadius: 16,
            colorScheme: colorScheme,
          ),

          SizedBox(height: ResponsiveUtils.spacing(context) * 2),

          // Section Header Shimmer
          Align(
            alignment: Alignment.centerLeft,
            child: _buildShimmerContainer(
              width: 200,
              height: 24,
              borderRadius: 8,
              colorScheme: colorScheme,
            ),
          ),

          SizedBox(height: ResponsiveUtils.spacing(context)),

          // Launch Cards Shimmer
          ...List.generate(
            3,
            (index) => Padding(
              padding: EdgeInsets.only(
                bottom: ResponsiveUtils.spacing(context),
              ),
              child: _buildLaunchCardShimmer(colorScheme),
            ),
          ),

          // Loading Indicator and Text
          const SizedBox(height: 40),
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            'Loading SpaceX data...',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLaunchCardShimmer(ColorScheme colorScheme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mission Patch Placeholder
                _buildShimmerContainer(
                  width: 60,
                  height: 60,
                  borderRadius: 8,
                  colorScheme: colorScheme,
                ),
                const SizedBox(width: 12),
                // Mission Info Placeholder
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShimmerContainer(
                        height: 20,
                        borderRadius: 4,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 8),
                      _buildShimmerContainer(
                        width: 120,
                        height: 16,
                        borderRadius: 4,
                        colorScheme: colorScheme,
                      ),
                      const SizedBox(height: 8),
                      _buildShimmerContainer(
                        width: 80,
                        height: 14,
                        borderRadius: 4,
                        colorScheme: colorScheme,
                      ),
                    ],
                  ),
                ),
                // Status Chip Placeholder
                _buildShimmerContainer(
                  width: 70,
                  height: 24,
                  borderRadius: 12,
                  colorScheme: colorScheme,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Launch Site Placeholder
            _buildShimmerContainer(
              width: 150,
              height: 14,
              borderRadius: 4,
              colorScheme: colorScheme,
            ),

            const SizedBox(height: 12),

            // Details Placeholder
            _buildShimmerContainer(
              height: 14,
              borderRadius: 4,
              colorScheme: colorScheme,
            ),
            const SizedBox(height: 4),
            _buildShimmerContainer(
              width: 200,
              height: 14,
              borderRadius: 4,
              colorScheme: colorScheme,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmerContainer({
    required double height,
    required double borderRadius,
    required ColorScheme colorScheme,
    double? width,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: _buildShimmerEffect(colorScheme),
    );
  }

  Widget _buildShimmerEffect(ColorScheme colorScheme) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 1500),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-1.0 + 2.0 * value, 0),
              end: Alignment(1.0 + 2.0 * value, 0),
              colors: [
                colorScheme.surfaceContainerHighest,
                colorScheme.surfaceContainerHigh,
                colorScheme.surfaceContainerHighest,
              ],
            ),
          ),
        );
      },
      onEnd: () {
        // Restart animation
      },
    );
  }
}
