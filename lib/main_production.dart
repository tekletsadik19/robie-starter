import 'package:shemanit/app/app.dart';
import 'package:shemanit/bootstrap.dart';
import 'package:shemanit/core/config/app_config.dart';
import 'package:shemanit/core/constants/environment.dart';

void main() {
  // Initialize production configuration
  AppConfig.initialize(Environment.production);

  bootstrap(() => const SecureApp());
}
