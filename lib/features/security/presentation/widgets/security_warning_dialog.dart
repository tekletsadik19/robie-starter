import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shemanit/features/security/domain/entities/security_status.dart';
import 'package:shemanit/features/security/domain/value_objects/app_version.dart';
import 'package:shemanit/features/security/domain/value_objects/threat_level.dart';
import 'package:shemanit/features/security/domain/value_objects/security_threat.dart';

class SecurityWarningDialog extends StatelessWidget {
  const SecurityWarningDialog({
    required this.securityStatus,
    required this.appVersion,
    this.onDismiss,
    this.onRetry,
    super.key,
  });

  final SecurityStatus securityStatus;
  final AppVersion appVersion;
  final VoidCallback? onDismiss;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final shouldShowSecurityWarning = !securityStatus.threatLevel.isSecure;

    if (!shouldShowSecurityWarning) {
      return const SizedBox.shrink();
    }

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _getWarningColor(securityStatus.threatLevel).withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            _buildSecurityWarning(context),
            const SizedBox(height: 24),
            _buildActions(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color:
                _getWarningColor(securityStatus.threatLevel).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SvgPicture.asset(
            _getWarningIcon(),
            width: 32,
            height: 32,
            colorFilter: ColorFilter.mode(
              _getWarningColor(securityStatus.threatLevel),
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Security Warning',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getWarningColor(securityStatus.threatLevel),
                ),
              ),
              Text(
                'Security risk detected',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }


  Widget _buildSecurityWarning(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _getWarningColor(securityStatus.threatLevel).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getWarningColor(securityStatus.threatLevel).withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                _getSecurityIcon(),
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(
                  _getWarningColor(securityStatus.threatLevel),
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                securityStatus.threatLevel.displayName,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: _getWarningColor(securityStatus.threatLevel),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'The following security issues were detected:',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          ...securityStatus.assessment.detectedThreats.map(
            (threat) => Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 16,
                    color: _getWarningColor(securityStatus.threatLevel),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      threat.description,
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _getSecurityRecommendation(),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    final theme = Theme.of(context);
    final shouldBlockApp = securityStatus.threatLevel.shouldBlockApp;

    return Row(
      children: [
        if (!shouldBlockApp) ...[
          TextButton(
            onPressed: onDismiss,
            child: const Text('Dismiss'),
          ),
          const SizedBox(width: 12),
        ],
        if (onRetry != null)
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: shouldBlockApp ? null : onDismiss,
            style: ElevatedButton.styleFrom(
              backgroundColor: shouldBlockApp
                  ? theme.colorScheme.error
                  : theme.colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            child: Text(shouldBlockApp ? 'Exit App' : 'Continue'),
          ),
        ),
      ],
    );
  }

  Color _getWarningColor(ThreatLevel level) {
    switch (level) {
      case ThreatLevel.none:
        return Colors.green;
      case ThreatLevel.low:
        return Colors.yellow.shade700;
      case ThreatLevel.medium:
        return Colors.orange;
      case ThreatLevel.high:
        return Colors.red.shade600;
      case ThreatLevel.critical:
        return Colors.red.shade800;
      default:
        return Colors.grey;
    }
  }

  String _getWarningIcon() {
    if (securityStatus.threatLevel.shouldBlockApp) {
      return 'assets/svg/security_warning.svg';
    } else if (securityStatus.threatLevel.requiresAction) {
      return 'assets/svg/shield_alert.svg';
    }
    return 'assets/svg/shield_alert.svg';
  }

  String _getSecurityIcon() {
    final threats = securityStatus.assessment.detectedThreats;
    if (threats.any((t) => t.type == ThreatType.jailbreak || t.type == ThreatType.root)) {
      return 'assets/svg/root_jailbreak.svg';
    } else if (threats.any((t) => t.type == ThreatType.emulator)) {
      return 'assets/svg/emulator_warning.svg';
    } else if (threats.any((t) => t.type == ThreatType.developmentMode)) {
      return 'assets/svg/developer_mode.svg';
    }
    return 'assets/svg/security_warning.svg';
  }

  String _getSecurityRecommendation() {
    final threats = securityStatus.assessment.detectedThreats;
    if (threats.any((t) => t.type == ThreatType.jailbreak || t.type == ThreatType.root)) {
      return 'For your security, please use this app on a non-jailbroken/rooted device.';
    } else if (threats.any((t) => t.type == ThreatType.emulator)) {
      return 'Please use this app on a physical device for the best security.';
    } else if (threats.any((t) => t.type == ThreatType.developmentMode)) {
      return 'Please disable Developer Options in your device settings.';
    }
    return securityStatus.primaryRecommendation;
  }

}
