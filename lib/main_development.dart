import 'package:shemanit/app/app.dart';
import 'package:shemanit/bootstrap.dart';
import 'package:shemanit/core/config/app_config.dart';
import 'package:shemanit/core/constants/environment.dart';

void main() {
  // Initialize development configuration
  AppConfig.initialize(Environment.development);

  bootstrap(() => const SecureApp());
}
