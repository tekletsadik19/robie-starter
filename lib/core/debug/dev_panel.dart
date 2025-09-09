import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shemanit/core/config/app_config.dart';
import 'package:shemanit/core/debug/debug_utils.dart';
import 'package:shemanit/core/debug/performance_monitor.dart';

/// Development panel for debugging and testing
class DevPanel extends StatefulWidget {
  const DevPanel({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<DevPanel> createState() => _DevPanelState();
}

class _DevPanelState extends State<DevPanel> with TickerProviderStateMixin {
  bool _showPanel = false;
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _togglePanel() {
    setState(() {
      _showPanel = !_showPanel;
      if (_showPanel) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode || !AppConfig.instance.debugConfig.enableDebugMode) {
      return widget.child;
    }

    return Scaffold(
      body: Stack(
        children: [
          widget.child,
          // Dev panel trigger
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            child: GestureDetector(
              onTap: _togglePanel,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.purple.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _showPanel ? Icons.close : Icons.developer_mode,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
          // Dev panel
          if (_showPanel)
            SlideTransition(
              position: _slideAnimation,
              child: Positioned(
                top: 0,
                right: 0,
                bottom: 0,
                width: MediaQuery.of(context).size.width * 0.8,
                child: const _DevPanelContent(),
              ),
            ),
        ],
      ),
    );
  }
}

/// Dev panel content
class _DevPanelContent extends StatefulWidget {
  const _DevPanelContent();

  @override
  State<_DevPanelContent> createState() => _DevPanelContentState();
}

class _DevPanelContentState extends State<_DevPanelContent>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
        elevation: 8,
        child: Container(
          color: Colors.grey[900],
          child: SafeArea(
            child: Column(
              children: [
                ColoredBox(
                  color: Colors.purple,
                  child: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.white,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white70,
                    labelStyle: const TextStyle(fontSize: 12),
                    tabs: const [
                      Tab(icon: Icon(Icons.info, size: 16), text: 'Info'),
                      Tab(icon: Icon(Icons.speed, size: 16), text: 'Perf'),
                      Tab(
                        icon: Icon(Icons.bug_report, size: 16),
                        text: 'Debug',
                      ),
                      Tab(icon: Icon(Icons.settings, size: 16), text: 'Tools'),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      _InfoTab(),
                      _PerformanceTab(),
                      _DebugTab(),
                      _ToolsTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

/// Info tab
class _InfoTab extends StatelessWidget {
  const _InfoTab();

  @override
  Widget build(BuildContext context) {
    final config = AppConfig.instance;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoCard('App Information', [
          _buildInfoRow('Name', config.fullAppName),
          _buildInfoRow('Environment', config.environment.name),
          _buildInfoRow('Platform', defaultTargetPlatform.name),
          _buildInfoRow(
            'Mode',
            kDebugMode
                ? 'Debug'
                : kProfileMode
                    ? 'Profile'
                    : 'Release',
          ),
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('API Configuration', [
          _buildInfoRow('Base URL', config.apiConfig.baseUrl),
          _buildInfoRow(
            'Timeout',
            '${config.apiConfig.connectTimeout.inSeconds}s',
          ),
          _buildInfoRow('Logging', config.apiConfig.enableLogging.toString()),
          _buildInfoRow(
            'Mock Data',
            config.apiConfig.enableMockData.toString(),
          ),
        ]),
        const SizedBox(height: 16),
        _buildInfoCard('Database Configuration', [
          _buildInfoRow('Name', config.databaseConfig.name),
          _buildInfoRow('Version', config.databaseConfig.version.toString()),
          _buildInfoRow(
            'Encryption',
            config.databaseConfig.enableEncryption.toString(),
          ),
          _buildInfoRow(
            'Cache Size',
            config.databaseConfig.cacheSize.toString(),
          ),
        ]),
      ],
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) => Card(
        color: Colors.grey[800],
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              ...children,
            ],
          ),
        ),
      );

  Widget _buildInfoRow(String label, String value) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                '$label:',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      );
}

/// Performance tab
class _PerformanceTab extends StatefulWidget {
  const _PerformanceTab();

  @override
  State<_PerformanceTab> createState() => _PerformanceTabState();
}

class _PerformanceTabState extends State<_PerformanceTab> {
  @override
  Widget build(BuildContext context) {
    final metrics = PerformanceMonitor.getMetrics();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    PerformanceMonitor.printSummary();
                    HapticFeedback.lightImpact();
                  },
                  child: const Text('Print Summary'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    PerformanceMonitor.clearMetrics();
                    setState(() {});
                    HapticFeedback.lightImpact();
                  },
                  child: const Text('Clear Metrics'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: metrics.length,
            itemBuilder: (context, index) {
              final metric = metrics[index];
              return ListTile(
                dense: true,
                title: Text(
                  metric.name,
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                subtitle: Text(
                  '${metric.duration.inMilliseconds}ms',
                  style: const TextStyle(color: Colors.white70, fontSize: 10),
                ),
                trailing: Text(
                  '${metric.timestamp.hour}:${metric.timestamp.minute.toString().padLeft(2, '0')}',
                  style: const TextStyle(color: Colors.white54, fontSize: 10),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Debug tab
class _DebugTab extends StatelessWidget {
  const _DebugTab();

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildDebugButton(
            'Print Widget Tree',
            () => DebugUtils.printWidgetTree(context),
          ),
          _buildDebugButton(
            'Print Render Tree',
            DebugUtils.printRenderTree,
          ),
          _buildDebugButton(
            'Print Layer Tree',
            DebugUtils.printLayerTree,
          ),
          _buildDebugButton(
            'Memory Usage',
            DebugUtils.printMemoryUsage,
          ),
          _buildDebugButton(
            'Trigger Haptic',
            DebugUtils.debugHaptic,
          ),
          const SizedBox(height: 16),
          const Text(
            'Debug Logs',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildDebugButton(
            'Log Debug Message',
            () => DebugUtils.logDebug('Test debug message'),
          ),
          _buildDebugButton(
            'Log Warning',
            () => DebugUtils.logWarning('Test warning message'),
          ),
          _buildDebugButton(
            'Log Error',
            () => DebugUtils.logError('Test error message'),
          ),
        ],
      );

  Widget _buildDebugButton(String title, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              onPressed();
              HapticFeedback.lightImpact();
            },
            child: Text(title),
          ),
        ),
      );
}

/// Tools tab
class _ToolsTab extends StatelessWidget {
  const _ToolsTab();

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildToolButton(
            'Copy App Info',
            () {
              final config = AppConfig.instance;
              final info = '''
App: ${config.fullAppName}
Environment: ${config.environment.name}
Platform: ${defaultTargetPlatform.name}
Mode: ${kDebugMode ? 'Debug' : kProfileMode ? 'Profile' : 'Release'}
Base URL: ${config.apiConfig.baseUrl}
Database: ${config.databaseConfig.name}
''';
              DebugUtils.debugCopy(info);
            },
          ),
          _buildToolButton(
            'Copy Performance Metrics',
            () {
              final metrics = PerformanceMonitor.getMetrics();
              final info = metrics
                  .map((m) => '${m.name}: ${m.duration.inMilliseconds}ms')
                  .join('\n');
              DebugUtils.debugCopy(info);
            },
          ),
          const SizedBox(height: 16),
          const Text(
            'Simulation Tools',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildToolButton(
            'Simulate Network Error',
            () => DebugUtils.logError('Simulated network error'),
          ),
          _buildToolButton(
            'Simulate Memory Pressure',
            () => DebugUtils.logWarning('Simulated memory pressure'),
          ),
          _buildToolButton(
            'Simulate Slow Operation',
            () async {
              PerformanceMonitor.startTimer('slow_operation');
              await Future<void>.delayed(const Duration(milliseconds: 500));
              PerformanceMonitor.endTimer('slow_operation');
            },
          ),
        ],
      );

  Widget _buildToolButton(String title, VoidCallback onPressed) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              onPressed();
              HapticFeedback.lightImpact();
            },
            child: Text(title),
          ),
        ),
      );
}
