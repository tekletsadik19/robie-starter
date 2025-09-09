import 'package:flutter/material.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';
import 'package:robbie_starter/features/spacex/domain/entities/launch_entity.dart';

/// Card widget for displaying launch information
class LaunchCard extends StatelessWidget {
  const LaunchCard({
    required this.launch,
    this.isUpcoming = false,
    super.key,
  });

  final LaunchEntity launch;
  final bool isUpcoming;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(ResponsiveUtils.padding(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Mission Patch or Placeholder
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: colorScheme.surfaceContainerHighest,
                  ),
                  child: launch.missionPatchSmall != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            launch.missionPatchSmall!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                _buildPlaceholderIcon(context),
                          ),
                        )
                      : _buildPlaceholderIcon(context),
                ),
                const SizedBox(width: 12),
                // Mission Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        launch.missionName.value,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        launch.launchDate.formatted,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        launch.rocket.displayName,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Status Indicator
                _buildStatusChip(context),
              ],
            ),

            // Launch Site
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 16,
                  color: colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  launch.launchSite.displayName,
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            // Details (if available)
            if (launch.details != null && launch.details!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                launch.details!,
                style: textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],

            // Additional Info Row
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Rocket Family
                _buildInfoChip(
                  context,
                  launch.rocket.family,
                  Icons.rocket,
                ),
                // Launch Site Type
                if (launch.launchSite.isKennedySpaceCenter)
                  _buildInfoChip(
                    context,
                    'KSC',
                    Icons.star,
                  )
                else if (launch.launchSite.isVandenberg)
                  _buildInfoChip(
                    context,
                    'VAFB',
                    Icons.location_city,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon(BuildContext context) {
    return Icon(
      Icons.rocket_launch,
      color: Theme.of(context).colorScheme.onSurfaceVariant,
      size: 30,
    );
  }

  Widget _buildStatusChip(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    Color backgroundColor;
    Color textColor;
    String statusText;
    IconData statusIcon;

    if (isUpcoming) {
      backgroundColor = colorScheme.primaryContainer;
      textColor = colorScheme.onPrimaryContainer;
      statusText = 'Upcoming';
      statusIcon = Icons.schedule;
    } else if (launch.wasSuccessful) {
      backgroundColor = Colors.green.shade100;
      textColor = Colors.green.shade800;
      statusText = 'Success';
      statusIcon = Icons.check_circle;
    } else if (launch.hasFailed) {
      backgroundColor = Colors.red.shade100;
      textColor = Colors.red.shade800;
      statusText = 'Failed';
      statusIcon = Icons.error;
    } else {
      backgroundColor = colorScheme.surfaceContainerHighest;
      textColor = colorScheme.onSurface;
      statusText = 'Unknown';
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
            statusText,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(BuildContext context, String label, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
          ),
        ],
      ),
    );
  }
}
