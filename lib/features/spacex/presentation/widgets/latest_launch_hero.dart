import 'package:flutter/material.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';

/// Hero widget for displaying the latest launch prominently
class LatestLaunchHero extends StatelessWidget {
  const LatestLaunchHero({
    required this.launch,
    super.key,
  });

  final LaunchEntity launch;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isTablet = ResponsiveUtils.isTablet(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primaryContainer,
            colorScheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.padding(context) * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(
                  Icons.star,
                  color: colorScheme.primary,
                  size: isTablet ? 28 : 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'Latest Launch',
                  style: (isTablet
                          ? textTheme.headlineMedium
                          : textTheme.headlineSmall)
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),

            SizedBox(height: ResponsiveUtils.spacing(context)),

            // Launch Details
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mission Patch
                if (launch.missionPatch != null)
                  Container(
                    width: isTablet ? 100 : 80,
                    height: isTablet ? 100 : 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme.surface,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        launch.missionPatch!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            _buildPlaceholderIcon(context, isTablet),
                      ),
                    ),
                  )
                else
                  Container(
                    width: isTablet ? 100 : 80,
                    height: isTablet ? 100 : 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme.surface,
                    ),
                    child: _buildPlaceholderIcon(context, isTablet),
                  ),

                SizedBox(width: ResponsiveUtils.spacing(context)),

                // Mission Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        launch.missionName.value,
                        style: (isTablet
                                ? textTheme.titleLarge
                                : textTheme.titleMedium)
                            ?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onPrimaryContainer,
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.spacing(context) * 0.5),

                      Text(
                        launch.launchDate.formattedWithTime,
                        style: (isTablet
                                ? textTheme.bodyLarge
                                : textTheme.bodyMedium)
                            ?.copyWith(
                          color:
                              colorScheme.onPrimaryContainer.withOpacity(0.8),
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.spacing(context) * 0.5),

                      // Status and Rocket
                      Row(
                        children: [
                          _buildStatusBadge(context),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              launch.rocket.displayName,
                              style: textTheme.bodySmall?.copyWith(
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Launch Site
            SizedBox(height: ResponsiveUtils.spacing(context)),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: isTablet ? 20 : 16,
                  color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                Text(
                  launch.launchSite.displayName,
                  style: (isTablet ? textTheme.bodyMedium : textTheme.bodySmall)
                      ?.copyWith(
                    color: colorScheme.onPrimaryContainer.withOpacity(0.7),
                  ),
                ),
              ],
            ),

            // Details
            if (launch.details != null && launch.details!.isNotEmpty) ...[
              SizedBox(height: ResponsiveUtils.spacing(context)),
              Text(
                launch.details!,
                style: (isTablet ? textTheme.bodyMedium : textTheme.bodySmall)
                    ?.copyWith(
                  color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                  height: 1.4,
                ),
                maxLines: isTablet ? 4 : 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon(BuildContext context, bool isTablet) {
    return Icon(
      Icons.rocket_launch,
      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
      size: isTablet ? 40 : 30,
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color backgroundColor;
    Color textColor;
    IconData statusIcon;

    if (launch.wasSuccessful) {
      backgroundColor = Colors.green.shade600;
      textColor = Colors.white;
      statusIcon = Icons.check_circle;
    } else if (launch.hasFailed) {
      backgroundColor = Colors.red.shade600;
      textColor = Colors.white;
      statusIcon = Icons.error;
    } else {
      backgroundColor = colorScheme.surface;
      textColor = colorScheme.onSurface;
      statusIcon = Icons.help;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            statusIcon,
            size: 14,
            color: textColor,
          ),
          const SizedBox(width: 4),
          Text(
            launch.statusText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }
}
