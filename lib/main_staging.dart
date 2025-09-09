import 'package:shemanit/app/app.dart';
import 'package:shemanit/bootstrap.dart';
import 'package:shemanit/core/config/app_config.dart';
import 'package:shemanit/core/constants/environment.dart';

void main() {
  // Initialize staging configuration
  AppConfig.initialize(Environment.staging);

  bootstrap(() => const SecureApp());
}
