import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:robbie_starter/features/security/domain/value_objects/app_version.dart';

part 'app_version_model.freezed.dart';
part 'app_version_model.g.dart';

@freezed
class AppVersionModel with _$AppVersionModel {
  const factory AppVersionModel({
    required String currentVersion,
    required String latestVersion,
    required String minimumSupportedVersion,
    required bool forceUpdate,
    required bool recommendUpdate,
    required String? updateMessage,
    required String? downloadUrl,
    required List<String> releaseNotes,
  }) = _AppVersionModel;

  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);
}

extension AppVersionModelExtension on AppVersionModel {
  AppVersion toDomain() {
    return AppVersion.parse(currentVersion);
  }
}

extension AppVersionExtension on AppVersion {
  AppVersionModel toModel() {
    return AppVersionModel(
      currentVersion: toString(),
      latestVersion:
          toString(), // This would need to be provided from external source
      minimumSupportedVersion:
          toString(), // This would need to be provided from external source
      forceUpdate: false, // This would need to be determined by business logic
      recommendUpdate:
          false, // This would need to be determined by business logic
      updateMessage: null,
      downloadUrl: null,
      releaseNotes: const [],
    );
  }
}
