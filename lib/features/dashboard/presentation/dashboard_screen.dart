import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/models/platform_app.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_icon_avatar.dart';
import '../../../shared/widgets/metric_tile.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_badge.dart';
import '../../restrictions/providers/restriction_coordinator_provider.dart';
import '../providers/dashboard_providers.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(dashboardStatsProvider);

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryCyan,
          backgroundColor: AppColors.darkCard,
          onRefresh: () async {
            final coordinator = ref.read(restrictionCoordinatorProvider);
            await coordinator.evaluateAndEnforce();
            ref.invalidate(dashboardStatsProvider);
          },
          child: statsAsync.when(
            data: (stats) => _buildDashboardContent(context, ref, stats),
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.primaryCyan),
            ),
            error: (err, _) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: AppColors.danger),
                  const SizedBox(height: 12),
                  Text('Failed to load dashboard: $err'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => ref.invalidate(dashboardStatsProvider),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(
    BuildContext context,
    WidgetRef ref,
    DashboardStats stats,
  ) {
    final totalLimit = stats.totalDailyLimitSeconds;
    final totalUsed = stats.totalScreenTimeSeconds;
    final double overallProgress = totalLimit > 0 ? (totalUsed / totalLimit).clamp(0.0, 1.0) : 0.0;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      children: [
        // App Bar Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.shield_rounded,
                    size: 22,
                    color: Color(0xFF0B132B),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FocusGuard',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.3,
                          ),
                    ),
                    Text(
                      'Today\'s Protection Active',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ],
                ),
              ],
            ),
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              tooltip: 'Settings',
              onPressed: () => context.push(AppRoutes.settings),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Main Goal Progress Card
        AppCard(
          gradient: AppColors.cardGradient,
          padding: const EdgeInsets.all(22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Daily Screen Allowance',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  StatusBadge(
                    label: totalLimit > 0 ? '${(overallProgress * 100).toInt()}% Used' : 'No Limit',
                    color: overallProgress >= 1.0
                        ? AppColors.danger
                        : (overallProgress >= 0.8 ? AppColors.warning : AppColors.primaryCyan),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DurationFormatter.formatSeconds(totalUsed),
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          totalLimit > 0
                              ? 'of ${DurationFormatter.formatSeconds(totalLimit)} configured limit'
                              : 'across monitored applications',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: overallProgress,
                          strokeWidth: 8,
                          backgroundColor: Colors.white.withOpacity(0.08),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            overallProgress >= 1.0
                                ? AppColors.danger
                                : (overallProgress >= 0.8
                                    ? AppColors.warning
                                    : AppColors.primaryCyan),
                          ),
                        ),
                        Icon(
                          overallProgress >= 1.0
                              ? Icons.lock_outline_rounded
                              : Icons.bolt_rounded,
                          color: Colors.white,
                          size: 26,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: LinearProgressIndicator(
                  value: overallProgress,
                  minHeight: 8,
                  backgroundColor: Colors.white.withOpacity(0.08),
                  valueColor: AlwaysStoppedAnimation<Color>(
                    overallProgress >= 1.0
                        ? AppColors.danger
                        : (overallProgress >= 0.8
                            ? AppColors.warning
                            : AppColors.primaryCyan),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Metric Tiles Grid
        Row(
          children: [
            Expanded(
              child: MetricTile(
                title: 'Remaining Time',
                value: DurationFormatter.formatSeconds(stats.remainingAllowedSeconds),
                subtitle: 'allowed today',
                icon: Icons.hourglass_bottom_rounded,
                iconColor: AppColors.primaryCyan,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricTile(
                title: 'Restricted Apps',
                value: '${stats.restrictedAppsCount}',
                subtitle: 'currently locked',
                icon: Icons.lock_person_outlined,
                iconColor: stats.restrictedAppsCount > 0 ? AppColors.danger : AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: MetricTile(
                title: 'Monitored Apps',
                value: '${stats.monitoredAppsCount}',
                subtitle: 'tracking active',
                icon: Icons.apps_rounded,
                iconColor: AppColors.info,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: MetricTile(
                title: 'Enforcement',
                value: 'Strict Shield',
                subtitle: 'Accessibility active',
                icon: Icons.security_rounded,
                iconColor: AppColors.primaryCyan,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        // Quick Action Shortcuts
        SectionHeader(
          title: 'Quick Actions',
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildQuickAction(
                context: context,
                label: 'Focus Session',
                icon: Icons.self_improvement_rounded,
                color: AppColors.accentPurple,
                onTap: () => context.push(AppRoutes.focusMode),
              ),
              _buildQuickAction(
                context: context,
                label: 'App Limits',
                icon: Icons.tune_rounded,
                color: AppColors.primaryBlue,
                onTap: () => context.push(AppRoutes.appLimits),
              ),
              _buildQuickAction(
                context: context,
                label: 'App Catalog',
                icon: Icons.grid_view_rounded,
                color: AppColors.primaryCyan,
                onTap: () => context.push(AppRoutes.appMonitoring),
              ),
              _buildQuickAction(
                context: context,
                label: 'Restrictions',
                icon: Icons.shield_outlined,
                color: AppColors.danger,
                onTap: () => context.push(AppRoutes.restrictions),
              ),
              _buildQuickAction(
                context: context,
                label: 'Routines',
                icon: Icons.schedule_rounded,
                color: AppColors.warning,
                onTap: () => context.push(AppRoutes.dailyRoutines),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // Most Used Monitored Apps
        SectionHeader(
          title: 'Monitored Application Usage',
          actionLabel: 'Add Apps',
          onAction: () => context.push(AppRoutes.appMonitoring),
        ),
        if (stats.mostUsedApps.isEmpty)
          AppCard(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
            child: Column(
              children: [
                const Icon(
                  Icons.phone_android_rounded,
                  size: 44,
                  color: AppColors.textMutedDark,
                ),
                const SizedBox(height: 12),
                Text(
                  'No Applications Monitored Yet',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  'Select apps from your device to enforce limits and prevent distraction.',
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.push(AppRoutes.appMonitoring),
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Select Apps to Monitor'),
                ),
              ],
            ),
          )
        else
          ...stats.mostUsedApps.map((app) => _buildAppUsageTile(context, app)),
        const SizedBox(height: 32),
      ],
    );
  }

  Widget _buildQuickAction({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 110,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: color.withOpacity(0.3), width: 1),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              const SizedBox(height: 8),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppUsageTile(BuildContext context, PlatformApp app) {
    final hasLimit = app.dailyLimitSeconds != null && app.dailyLimitSeconds! > 0;
    final progress = app.usageProgress;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        onTap: () => context.push(AppRoutes.appLimitConfig, extra: app),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          app.appName,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (app.isRestricted)
                        const StatusBadge(
                          label: 'Restricted',
                          color: AppColors.danger,
                          icon: Icons.lock_outline_rounded,
                        )
                      else if (hasLimit)
                        Text(
                          '${DurationFormatter.formatSeconds(app.todayUsageSeconds)} / ${DurationFormatter.formatSeconds(app.dailyLimitSeconds!)}',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        )
                      else
                        Text(
                          DurationFormatter.formatSeconds(app.todayUsageSeconds),
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (hasLimit) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 6,
                        backgroundColor: Colors.white.withOpacity(0.06),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progress >= 1.0
                              ? AppColors.danger
                              : (progress >= 0.8 ? AppColors.warning : AppColors.primaryCyan),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      app.isRestricted
                          ? 'Daily limit exceeded. Tap for emergency unlock.'
                          : '${DurationFormatter.formatSeconds(app.remainingSeconds)} remaining',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: app.isRestricted ? AppColors.danger : AppColors.textSecondaryDark,
                          ),
                    ),
                  ] else ...[
                    Text(
                      'No limit set • Tap to configure',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.primaryCyan,
                          ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

