import 'package:robbie_starter/features/security/domain/aggregates/app_update_policy.dart';
import 'package:robbie_starter/features/security/domain/value_objects/app_version.dart';

abstract class IAppVersionRepository {
  Future<AppVersion> getCurrentVersion();
  Future<AppVersion> getLatestVersion();
  Future<AppVersion> getMinimumSupportedVersion();
  Future<List<String>> getReleaseNotes();
  Future<String?> getDownloadUrl();
}

class AppUpdateService {
  const AppUpdateService(this._versionRepository);

  final IAppVersionRepository _versionRepository;

  Future<AppUpdatePolicy> evaluateUpdatePolicy() async {
    final currentVersion = await _versionRepository.getCurrentVersion();
    final latestVersion = await _versionRepository.getLatestVersion();
    final minimumSupportedVersion =
        await _versionRepository.getMinimumSupportedVersion();
    final releaseNotes = await _versionRepository.getReleaseNotes();
    final downloadUrl = await _versionRepository.getDownloadUrl();

    return AppUpdatePolicy.evaluate(
      currentVersion: currentVersion,
      latestVersion: latestVersion,
      minimumSupportedVersion: minimumSupportedVersion,
      releaseNotes: releaseNotes,
      downloadUrl: downloadUrl,
    );
  }

  /// Business rule: Determines grace period for updates
  Duration getUpdateGracePeriod(UpdatePriority priority) {
    switch (priority) {
      case UpdatePriority.critical:
        return const Duration(days: 3);
      case UpdatePriority.required:
        return const Duration(days: 14);
      case UpdatePriority.recommended:
        return const Duration(days: 30);
      case UpdatePriority.optional:
        return const Duration(days: 90);
    }
  }

  /// Business rule: Determines if user can postpone update
  bool canPostponeUpdate(AppUpdatePolicy policy) {
    if (policy.updateRequirement == null) return true;

    final requirement = policy.updateRequirement!;

    // Critical updates cannot be postponed
    if (requirement.priority == UpdatePriority.critical) {
      return false;
    }

    // Required updates can be postponed until deadline
    if (requirement.priority == UpdatePriority.required) {
      return !requirement.isOverdue;
    }

    // Recommended and optional updates can always be postponed
    return true;
  }

  /// Business rule: Determines update notification frequency
  Duration getNotificationFrequency(UpdatePriority priority) {
    switch (priority) {
      case UpdatePriority.critical:
        return const Duration(hours: 1);
      case UpdatePriority.required:
        return const Duration(hours: 12);
      case UpdatePriority.recommended:
        return const Duration(days: 3);
      case UpdatePriority.optional:
        return const Duration(days: 7);
    }
  }
}
