import 'package:flutter/material.dart';
import 'package:robbie_starter/core/responsive/responsive_utils.dart';
import 'package:robbie_starter/features/counter/presentation/pages/counter_page.dart';
import 'package:robbie_starter/features/spacex/presentation/pages/spacex_page.dart';

/// Main navigation widget with bottom navigation bar
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = [
    CounterPage(),
    SpaceXPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTablet = ResponsiveUtils.isTablet(context);

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        height: isTablet ? 80 : 70,
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.add),
            selectedIcon: Icon(
              Icons.add,
              color: colorScheme.primary,
            ),
            label: 'Counter',
            tooltip: 'Counter Demo',
          ),
          NavigationDestination(
            icon: const Icon(Icons.rocket_launch_outlined),
            selectedIcon: Icon(
              Icons.rocket_launch,
              color: colorScheme.primary,
            ),
            label: 'SpaceX',
            tooltip: 'SpaceX Launches',
          ),
        ],
      ),
    );
  }
}
