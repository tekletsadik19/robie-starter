import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robbie_starter/core/di/injection_container.dart';
import 'package:robbie_starter/features/spacex/application/blocs/spacex_bloc.dart';
import 'package:robbie_starter/features/spacex/presentation/widgets/spacex_view.dart';

/// Page for displaying SpaceX data
class SpaceXPage extends StatelessWidget {
  const SpaceXPage({super.key});

  static const routeName = '/spacex';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          sl<SpaceXBloc>()..add(const SpaceXEvent.loadAllData()),
      child: const SpaceXView(),
    );
  }
}
