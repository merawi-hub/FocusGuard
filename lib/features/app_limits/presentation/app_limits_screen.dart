import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/models/platform_app.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_icon_avatar.dart';
import '../../../shared/widgets/status_badge.dart';

class AppLimitsScreen extends ConsumerWidget {
  const AppLimitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final monitoredAppsAsync = ref.watch(monitoredAppsStreamProvider);
    final limitsAsync = ref.watch(appLimitsStreamProvider);
    final usageAsync = ref.watch(todayUsageStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Limits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            tooltip: 'Add monitored application',
            onPressed: () => context.push(AppRoutes.appMonitoring),
          ),
        ],
      ),
      body: monitoredAppsAsync.when(
        data: (monitoredList) {
          if (monitoredList.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.tune_rounded, size: 54, color: AppColors.textMutedDark),
                  const SizedBox(height: 16),
                  Text(
                    'No Monitored Apps Found',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Add applications from the catalog first to configure daily limits.',
                    style: Theme.of(context).textTheme.bodySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => context.push(AppRoutes.appMonitoring),
                    child: const Text('Select Apps to Monitor'),
                  ),
                ],
              ),
            );
          }

          final limits = limitsAsync.asData?.value ?? [];
          final usage = usageAsync.asData?.value ?? {};

          final limitsMap = {for (final l in limits) l.monitoredAppId: l};

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: monitoredList.length,
            itemBuilder: (context, index) {
              final dbApp = monitoredList[index];
              final limit = limitsMap[dbApp.id];
              final used = usage[dbApp.platformAppId] ?? 0;

              final app = PlatformApp(
                packageName: dbApp.platformAppId,
                appName: dbApp.appName,
                iconBase64: dbApp.iconReference,
                isMonitored: dbApp.isMonitored,
                dailyLimitSeconds: limit?.dailyLimitSeconds,
                todayUsageSeconds: used,
              );

              final hasLimit = limit != null && limit.isEnabled;

              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppCard(
                  onTap: () => context.push(AppRoutes.appLimitConfig, extra: app),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      AppIconAvatar(
                        iconBytes: app.iconBytes,
                        appName: app.appName,
                        size: 46,
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(app.appName, style: Theme.of(context).textTheme.titleLarge),
                            const SizedBox(height: 4),
                            if (hasLimit) ...[
                              Text(
                                'Limit: ${DurationFormatter.formatSeconds(limit.dailyLimitSeconds)} (${limit.enforcementMode.toUpperCase()})',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.primaryCyan,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Used today: ${DurationFormatter.formatSeconds(used)}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ] else ...[
                              Text(
                                'No daily limit configured',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                      color: AppColors.textMutedDark,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      StatusBadge(
                        label: hasLimit ? 'Active' : 'Unconfigured',
                        color: hasLimit ? AppColors.success : AppColors.textMutedDark,
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.chevron_right_rounded, color: AppColors.textMutedDark),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryCyan)),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

