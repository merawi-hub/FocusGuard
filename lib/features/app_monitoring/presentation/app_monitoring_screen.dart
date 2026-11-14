import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/models/platform_app.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_icon_avatar.dart';
import '../../../shared/widgets/status_badge.dart';

class AppMonitoringScreen extends ConsumerStatefulWidget {
  const AppMonitoringScreen({super.key});

  @override
  ConsumerState<AppMonitoringScreen> createState() => _AppMonitoringScreenState();
}

class _AppMonitoringScreenState extends ConsumerState<AppMonitoringScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All'; // 'All', 'Monitored', 'Unmonitored'

  @override
  Widget build(BuildContext context) {
    final availableAppsAsync = ref.watch(availableAppsProvider);
    final monitoredAppsAsync = ref.watch(monitoredAppsStreamProvider);
    final usageStatsAsync = ref.watch(todayUsageStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Catalog'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'Refresh installed apps',
            onPressed: () {
              ref.invalidate(availableAppsProvider);
              ref.invalidate(todayUsageStatsProvider);
            },
          ),
        ],
      ),
      body: availableAppsAsync.when(
        data: (apps) {
          final monitoredApps = monitoredAppsAsync.asData?.value ?? [];
          final usageMap = usageStatsAsync.asData?.value ?? {};

          final monitoredPackageMap = {
            for (final m in monitoredApps) m.platformAppId: m
          };

          // Combine raw installed apps with database monitoring status and today's usage
          final List<PlatformApp> combinedApps = apps.map((app) {
            final monitoredRecord = monitoredPackageMap[app.packageName];
            final usedSeconds = usageMap[app.packageName] ?? 0;
            return app.copyWith(
              isMonitored: monitoredRecord != null && monitoredRecord.isMonitored,
              todayUsageSeconds: usedSeconds,
            );
          }).toList();

          // Filter by search query
          var filtered = combinedApps.where((a) {
            final matchesQuery = _searchQuery.isEmpty ||
                a.appName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                a.packageName.toLowerCase().contains(_searchQuery.toLowerCase());
            if (!matchesQuery) return false;

            if (_selectedFilter == 'Monitored') return a.isMonitored;
            if (_selectedFilter == 'Unmonitored') return !a.isMonitored;
            return true;
          }).toList();

          return Column(
            children: [
              // Search & Filter Header
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search applications...',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                      onChanged: (val) => setState(() => _searchQuery = val),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildFilterChip('All (${combinedApps.length})', 'All'),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Monitored (${combinedApps.where((a) => a.isMonitored).length})',
                          'Monitored',
                        ),
                        const SizedBox(width: 8),
                        _buildFilterChip(
                          'Available (${combinedApps.where((a) => !a.isMonitored).length})',
                          'Unmonitored',
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // App List
              Expanded(
                child: filtered.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textMutedDark),
                            const SizedBox(height: 12),
                            Text('No applications found', style: Theme.of(context).textTheme.titleLarge),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) {
                          final app = filtered[index];
                          return _buildAppItem(context, app, monitoredPackageMap[app.packageName]);
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: AppColors.primaryCyan),
              SizedBox(height: 16),
              Text('Scanning installed applications...'),
            ],
          ),
        ),
        error: (err, _) => Center(child: Text('Error scanning apps: $err')),
      ),
    );
  }

  Widget _buildFilterChip(String label, String filterKey) {
    final isSelected = _selectedFilter == filterKey;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => setState(() => _selectedFilter = filterKey),
      selectedColor: AppColors.primaryCyan.withOpacity(0.2),
      backgroundColor: AppColors.darkCard,
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected ? AppColors.primaryCyan : AppColors.textSecondaryDark,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.primaryCyan : AppColors.darkBorder,
      ),
    );
  }

  Widget _buildAppItem(
    BuildContext context,
    PlatformApp app,
    MonitoredApp? dbRecord,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: AppCard(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            AppIconAvatar(
              iconBytes: app.iconBytes,
              appName: app.appName,
              size: 44,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    app.appName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        DurationFormatter.formatSeconds(app.todayUsageSeconds),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: app.todayUsageSeconds > 0 ? AppColors.primaryCyan : null,
                            ),
                      ),
                      const SizedBox(width: 8),
                      StatusBadge(
                        label: app.isMonitored ? 'Monitored' : 'Unmonitored',
                        color: app.isMonitored ? AppColors.success : AppColors.textMutedDark,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Switch(
              value: app.isMonitored,
              onChanged: (enabled) async {
                final db = ref.read(appDatabaseProvider);
                if (enabled) {
                  await db.insertMonitoredApp(
                    MonitoredAppsCompanion(
                      platformAppId: drift.Value(app.packageName),
                      appName: drift.Value(app.appName),
                      iconReference: drift.Value(app.iconBase64),
                      isMonitored: const drift.Value(true),
                    ),
                  );
                } else {
                  if (dbRecord != null) {
                    await db.deleteMonitoredApp(dbRecord.id);
                  }
                }
                ref.invalidate(availableAppsProvider);
              },
            ),
          ],
        ),
      ),
    );
  }
}

