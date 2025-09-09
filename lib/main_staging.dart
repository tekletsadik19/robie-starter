import 'package:robbie_starter/app/app.dart';
import 'package:robbie_starter/bootstrap.dart';
import 'package:robbie_starter/core/config/app_config.dart';
import 'package:robbie_starter/core/constants/environment.dart';

void main() {
  // Initialize staging configuration
  AppConfig.initialize(Environment.staging);

  bootstrap(() => const SecureApp());
}
