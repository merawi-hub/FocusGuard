import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../../../shared/models/permission_status.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/section_header.dart';
import '../../../shared/widgets/status_badge.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> with WidgetsBindingObserver {
  int _emergencyDuration = AppConstants.defaultEmergencyUnlockMinutes;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.invalidate(permissionsStatusProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissionsAsync = ref.watch(permissionsStatusProvider);
    final engine = ref.read(restrictionEngineProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings & Permissions'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: [
          // Platform Permissions Center
          SectionHeader(title: 'Android System Permissions'),
          permissionsAsync.when(
            data: (permissions) => _buildPermissionsSection(context, permissions, engine),
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryCyan)),
            error: (err, _) => Text('Error loading permissions: $err'),
          ),
          const SizedBox(height: 24),

          // Enforcement Settings
          SectionHeader(title: 'Enforcement & Emergency Preferences'),
          AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Emergency Unlock Window', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text('Temporary window granted upon confirmation', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    DropdownButton<int>(
                      value: _emergencyDuration,
                      dropdownColor: AppColors.darkCard,
                      items: const [
                        DropdownMenuItem(value: 5, child: Text('5 minutes')),
                        DropdownMenuItem(value: 10, child: Text('10 minutes')),
                        DropdownMenuItem(value: 15, child: Text('15 minutes')),
                      ],
                      onChanged: (val) {
                        if (val != null) setState(() => _emergencyDuration = val);
                      },
                    ),
                  ],
                ),
                const Divider(color: AppColors.darkBorder, height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Daily Reset Boundary', style: Theme.of(context).textTheme.titleLarge),
                        const SizedBox(height: 2),
                        Text('Usage counters reset each night', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    const Text('00:00 (Midnight)', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryCyan)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Privacy & Local Storage
          SectionHeader(title: 'Privacy & Offline Storage'),
          AppCard(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shield_outlined, color: AppColors.success, size: 22),
                    const SizedBox(width: 10),
                    Text('100% Offline Architecture', style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'FocusGuard stores all application usage and restriction logs strictly in an offline local SQLite database on your device. Zero analytics or personal usage telemetry are ever transmitted to remote servers.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Data Management
          SectionHeader(title: 'System Actions'),
          AppCard(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.sync_rounded, color: AppColors.primaryCyan),
                  title: const Text('Run Background WorkManager Sync'),
                  subtitle: const Text('Triggers immediate background usage evaluation & WorkManager re-queue'),
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await engine.schedulePeriodicMonitoring();
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Background WorkManager task triggered.'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
                const Divider(color: AppColors.darkBorder),
                ListTile(
                  leading: const Icon(Icons.delete_sweep_outlined, color: AppColors.danger),
                  title: const Text('Reset All Active Restrictions'),
                  subtitle: const Text('Clears all current lockouts and temporary unlocks'),
                  onTap: () async {
                    final messenger = ScaffoldMessenger.of(context);
                    await engine.applyApplicationRestrictions([]);
                    ref.invalidate(restrictedPackagesProvider);
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('All restrictions cleared successfully.'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // App Info
          Center(
            child: Column(
              children: [
                Text(
                  '${AppConstants.appName} v${AppConstants.appVersion}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Native Android 8.0+ UsageStats & Accessibility Architecture',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMutedDark,
                        fontSize: 10,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildPermissionsSection(
    BuildContext context,
    PlatformPermissionsStatus permissions,
    dynamic engine,
  ) {
    return Column(
      children: [
        _buildPermissionItem(
          context: context,
          title: 'Usage Access Permission',
          subtitle: 'Required for UsageStatsManager',
          isGranted: permissions.hasUsageStats,
          onTap: () => engine.requestUsageAuthorization(),
        ),
        const SizedBox(height: 8),
        _buildPermissionItem(
          context: context,
          title: 'Overlay Permission (System Alert)',
          subtitle: 'Required to present restriction shield',
          isGranted: permissions.hasOverlay,
          onTap: () => engine.requestOverlayAuthorization(),
        ),
        const SizedBox(height: 8),
        _buildPermissionItem(
          context: context,
          title: 'Accessibility Detection Service',
          subtitle: 'Required for immediate foreground app interception',
          isGranted: permissions.hasAccessibility,
          onTap: () => engine.requestAccessibilityAuthorization(),
        ),
        const SizedBox(height: 8),
        _buildPermissionItem(
          context: context,
          title: 'Notifications',
          subtitle: 'Delivers 50%, 80%, 100% threshold alerts',
          isGranted: permissions.hasNotifications,
          onTap: () => engine.requestNotificationAuthorization(),
        ),
      ],
    );
  }

  Widget _buildPermissionItem({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool isGranted,
    required VoidCallback onTap,
  }) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 14)),
                const SizedBox(height: 2),
                Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          StatusBadge(
            label: isGranted ? 'Enabled' : 'Disabled',
            color: isGranted ? AppColors.success : AppColors.warning,
            icon: isGranted ? Icons.check_circle_outline : Icons.warning_amber_rounded,
          ),
        ],
      ),
    );
  }
}
