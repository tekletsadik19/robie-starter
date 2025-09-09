import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robbie_starter/core/di/injection_container.dart';
import 'package:robbie_starter/features/security/security_feature.dart';
import 'package:robbie_starter/app/view/app.dart';

class SecureApp extends StatefulWidget {
  const SecureApp({super.key});

  @override
  State<SecureApp> createState() => _SecureAppState();
}

class _SecureAppState extends State<SecureApp> {
  bool _securityCheckPassed = false;

  @override
  Widget build(BuildContext context) {
    if (!_securityCheckPassed) {
      return BlocProvider(
        create: (context) => getIt<SecurityBloc>(),
        child: SecurityCheckPage(
          onSecurityCheckComplete: () {
            setState(() {
              _securityCheckPassed = true;
            });
          },
        ),
      );
    }

    return const App();
  }
}
