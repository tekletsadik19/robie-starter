import 'package:equatable/equatable.dart';
import 'package:shemanit/features/security/domain/value_objects/app_version.dart';
import 'package:shemanit/features/security/domain/events/security_event.dart';

enum UpdatePriority {
  optional,
  recommended,
  required,
  critical,
}

class UpdateRequirement extends Equatable {
  const UpdateRequirement({
    required this.priority,
    required this.reason,
    this.deadline,
  });

  final UpdatePriority priority;
  final String reason;
  final DateTime? deadline;

  bool get isForced =>
      priority == UpdatePriority.required ||
      priority == UpdatePriority.critical;
  bool get isOptional => priority == UpdatePriority.optional;
  bool get hasDeadline => deadline != null;
  bool get isOverdue => deadline != null && DateTime.now().isAfter(deadline!);

  @override
  List<Object?> get props => [priority, reason, deadline];
}

class AppUpdatePolicy extends Equatable {
  factory AppUpdatePolicy.evaluate({
    required AppVersion currentVersion,
    required AppVersion latestVersion,
    required AppVersion minimumSupportedVersion,
    required List<String> releaseNotes,
    String? downloadUrl,
  }) {
    final events = <SecurityDomainEvent>[];
    UpdateRequirement? requirement;

    // Check if current version is supported
    if (currentVersion.isOlderThan(minimumSupportedVersion)) {
      requirement = UpdateRequirement(
        priority: UpdatePriority.critical,
        reason: 'Your app version is no longer supported for security reasons.',
        deadline: DateTime.now().add(const Duration(days: 7)),
      );

      events.add(
        ForceUpdateRequired(
          currentVersion: currentVersion.toString(),
          requiredVersion: latestVersion.toString(),
          reason: requirement.reason,
          occurredAt: DateTime.now(),
        ),
      );
    }
    // Check if there are security updates
    else if (_hasSecurityUpdates(releaseNotes)) {
      requirement = UpdateRequirement(
        priority: UpdatePriority.required,
        reason: 'Security updates are available and recommended.',
        deadline: DateTime.now().add(const Duration(days: 14)),
      );

      events.add(
        ForceUpdateRequired(
          currentVersion: currentVersion.toString(),
          requiredVersion: latestVersion.toString(),
          reason: requirement.reason,
          occurredAt: DateTime.now(),
        ),
      );
    }
    // Check if update is available
    else if (currentVersion.isOlderThan(latestVersion)) {
      requirement = const UpdateRequirement(
        priority: UpdatePriority.recommended,
        reason: 'New features and improvements are available.',
      );
    }

    return AppUpdatePolicy._(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      minimumSupportedVersion: minimumSupportedVersion,
      updateRequirement: requirement,
      releaseNotes: releaseNotes,
      downloadUrl: downloadUrl,
      domainEvents: events,
    );
  }
  const AppUpdatePolicy._({
    required this.currentVersion,
    required this.latestVersion,
    required this.minimumSupportedVersion,
    required this.updateRequirement,
    required this.releaseNotes,
    required this.downloadUrl,
    required this.domainEvents,
  });

  final AppVersion currentVersion;
  final AppVersion latestVersion;
  final AppVersion minimumSupportedVersion;
  final UpdateRequirement? updateRequirement;
  final List<String> releaseNotes;
  final String? downloadUrl;
  final List<SecurityDomainEvent> domainEvents;

  bool get needsUpdate => updateRequirement != null;
  bool get mustUpdate => updateRequirement?.isForced ?? false;
  bool get canSkipUpdate => updateRequirement?.isOptional ?? true;
  bool get isCurrentVersionSupported =>
      currentVersion.isCompatibleWith(minimumSupportedVersion);
  bool get hasNewVersion => currentVersion.isOlderThan(latestVersion);

  String get updateMessage {
    if (updateRequirement == null) return 'Your app is up to date.';
    return updateRequirement!.reason;
  }

  static bool _hasSecurityUpdates(List<String> releaseNotes) {
    final securityKeywords = [
      'security',
      'vulnerability',
      'fix',
      'patch',
      'exploit',
      'breach',
    ];

    return releaseNotes.any(
      (note) => securityKeywords
          .any((keyword) => note.toLowerCase().contains(keyword)),
    );
  }

  AppUpdatePolicy clearEvents() {
    return AppUpdatePolicy._(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      minimumSupportedVersion: minimumSupportedVersion,
      updateRequirement: updateRequirement,
      releaseNotes: releaseNotes,
      downloadUrl: downloadUrl,
      domainEvents: const [],
    );
  }

  @override
  List<Object?> get props => [
        currentVersion,
        latestVersion,
        minimumSupportedVersion,
        updateRequirement,
        releaseNotes,
        downloadUrl,
      ];
}
