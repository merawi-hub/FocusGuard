import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../app/theme/colors.dart';
import '../../../core/database/database_provider.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../../../core/utilities/duration_formatter.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/app_icon_avatar.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_badge.dart';
import '../providers/restriction_coordinator_provider.dart';

class RestrictionsScreen extends ConsumerStatefulWidget {
  const RestrictionsScreen({super.key});

  @override
  ConsumerState<RestrictionsScreen> createState() => _RestrictionsScreenState();
}

class _RestrictionsScreenState extends ConsumerState<RestrictionsScreen> {
  final TextEditingController _reasonController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _showEmergencyUnlockDialog(
    BuildContext context,
    int monitoredAppId,
    String packageName,
    String appName,
  ) {
    _reasonController.clear();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.darkCard,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: AppColors.warning),
            const SizedBox(width: 10),
            const Text('Emergency Unlock'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You have reached your daily limit for $appName.',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Emergency unlock grants a temporary 10-minute window. Please provide a deliberate reason to keep yourself accountable:',
              style: TextStyle(fontSize: 13, color: AppColors.textSecondaryDark),
            ),
            const SizedBox(height: 14),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                hintText: 'e.g., Urgent bank confirmation code',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.warning,
              foregroundColor: Colors.black,
            ),
            onPressed: () async {
              final reason = _reasonController.text.trim().isEmpty
                  ? 'User requested manual unlock'
                  : _reasonController.text.trim();
              Navigator.of(ctx).pop();

              final messenger = ScaffoldMessenger.of(context);
              final coordinator = ref.read(restrictionCoordinatorProvider);
              final success = await coordinator.requestEmergencyUnlock(
                monitoredAppId: monitoredAppId,
                packageName: packageName,
                reason: reason,
                durationMinutes: 10,
              );

              if (mounted) {
                ref.invalidate(restrictedPackagesProvider);
                ref.invalidate(recentRestrictionEventsProvider);
                messenger.showSnackBar(
                  SnackBar(
                    content: Text(
                      success
                          ? 'Emergency unlock active for 10 minutes'
                          : 'Failed to apply emergency unlock',
                    ),
                    backgroundColor: success ? AppColors.success : AppColors.danger,
                  ),
                );
              }
            },
            child: const Text('Confirm Unlock (10m)'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final restrictedPkgsAsync = ref.watch(restrictedPackagesProvider);
    final monitoredAppsAsync = ref.watch(monitoredAppsStreamProvider);
    final eventsAsync = ref.watch(recentRestrictionEventsProvider);
    final usageAsync = ref.watch(todayUsageStatsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Active Restrictions'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Information Banner
          AppCard(
            gradient: AppColors.cardGradient,
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  size: 40,
                  color: AppColors.primaryCyan,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Distraction Shield System',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Restricted applications are intercepted by the native Android Accessibility Service and blocked with the FocusGuard shield screen.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Active Restrictions List
          SectionHeader(title: 'Currently Locked Applications'),
          restrictedPkgsAsync.when(
            data: (restrictedPkgs) {
              if (restrictedPkgs.isEmpty) {
                return AppCard(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.check_circle_outline_rounded,
                          size: 42,
                          color: AppColors.success,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'No Applications Currently Restricted',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Apps that exceed their daily limits will appear here.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                );
              }

              final monitoredApps = monitoredAppsAsync.asData?.value ?? [];
              final usage = usageAsync.asData?.value ?? {};

              return Column(
                children: restrictedPkgs.map((pkg) {
                  final dbApp = monitoredApps.where((a) => a.platformAppId == pkg).firstOrNull;
                  final appName = dbApp?.appName ?? pkg;
                  final used = usage[pkg] ?? 0;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          AppIconAvatar(
                            iconBytes: null,
                            appName: appName,
                            size: 44,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(appName, style: Theme.of(context).textTheme.titleLarge),
                                const SizedBox(height: 2),
                                Text(
                                  'Used today: ${DurationFormatter.formatSeconds(used)}',
                                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                        color: AppColors.danger,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.warning.withOpacity(0.2),
                              foregroundColor: AppColors.warning,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                              visualDensity: VisualDensity.compact,
                            ),
                            onPressed: () {
                              if (dbApp != null) {
                                _showEmergencyUnlockDialog(context, dbApp.id, pkg, appName);
                              }
                            },
                            child: const Text('Unlock (10m)'),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryCyan)),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),
          const SizedBox(height: 24),

          // Restriction Events History Log
          SectionHeader(title: 'Restriction Activity Log'),
          eventsAsync.when(
            data: (events) {
              if (events.isEmpty) {
                return AppCard(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'No restriction events recorded yet today.',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                );
              }

              final dateFormat = DateFormat('MMM d, h:mm a');

              return Column(
                children: events.map((event) {
                  Color badgeColor = AppColors.info;
                  IconData icon = Icons.info_outline;

                  if (event.eventType.contains('restriction')) {
                    badgeColor = AppColors.danger;
                    icon = Icons.lock_outline;
                  } else if (event.eventType.contains('warning')) {
                    badgeColor = AppColors.warning;
                    icon = Icons.warning_amber;
                  } else if (event.eventType.contains('unlock')) {
                    badgeColor = AppColors.success;
                    icon = Icons.lock_open_rounded;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: AppCard(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          Icon(icon, size: 20, color: badgeColor),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    StatusBadge(
                                      label: event.eventType.replaceAll('_', ' ').toUpperCase(),
                                      color: badgeColor,
                                    ),
                                    Text(
                                      dateFormat.format(event.occurredAt),
                                      style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
                                    ),
                                  ],
                                ),
                                if (event.details != null) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    event.details!,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryCyan)),
            error: (err, _) => Center(child: Text('Error: $err')),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

