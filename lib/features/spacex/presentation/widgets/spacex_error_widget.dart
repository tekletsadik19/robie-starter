import 'package:flutter/material.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';

/// Error widget for SpaceX data loading failures
class SpaceXErrorWidget extends StatelessWidget {
  const SpaceXErrorWidget({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isTablet = ResponsiveUtils.isTablet(context);

    return Padding(
      padding: EdgeInsets.all(ResponsiveUtils.padding(context)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon
            Container(
              width: isTablet ? 120 : 100,
              height: isTablet ? 120 : 100,
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.rocket_launch_outlined,
                size: isTablet ? 60 : 50,
                color: colorScheme.onErrorContainer,
              ),
            ),

            SizedBox(height: ResponsiveUtils.spacing(context) * 2),

            // Error Title
            Text(
              'Houston, we have a problem!',
              style: (isTablet ? textTheme.headlineSmall : textTheme.titleLarge)
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: ResponsiveUtils.spacing(context)),

            // Error Message
            Text(
              message,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: ResponsiveUtils.spacing(context) * 3),

            // Retry Button
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: FilledButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.padding(context) * 2,
                  vertical: ResponsiveUtils.padding(context),
                ),
              ),
            ),

            SizedBox(height: ResponsiveUtils.spacing(context)),

            // Help Text
            Text(
              'Make sure you have an internet connection',
              style: textTheme.bodySmall?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
