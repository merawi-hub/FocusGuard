import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app/theme/colors.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/route_constants.dart';
import '../../../core/platform/restriction_engine_provider.dart';
import '../../../shared/models/permission_status.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../shared/widgets/status_badge.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> with WidgetsBindingObserver {
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
      // Re-check permissions when returning from system settings
      ref.invalidate(permissionsStatusProvider);
    }
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(AppConstants.keyFirstLaunch, true);
    if (mounted) {
      context.go(AppRoutes.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final permissionsAsync = ref.watch(permissionsStatusProvider);
    final engine = ref.read(restrictionEngineProvider);

    return Scaffold(
      body: SafeArea(
        child: permissionsAsync.when(
          data: (permissions) => _buildContent(context, permissions, engine),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('Error: $err')),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PlatformPermissionsStatus permissions,
    dynamic engine,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: [
        const SizedBox(height: 12),
        // Logo / Icon
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryCyan.withOpacity(0.3),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Icon(
              Icons.shield_rounded,
              size: 54,
              color: Color(0xFF0B132B),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Welcome to FocusGuard',
          style: Theme.of(context).textTheme.displayLarge?.copyWith(fontSize: 26),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'A privacy-first digital wellbeing companion designed to enforce deliberate limits on distracting applications.',
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        Text(
          'Required Android Permissions',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 6),
        Text(
          'FocusGuard runs offline. Permissions are strictly used locally to measure usage and display your restriction screens.',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 16),

        // 1. Usage Stats Permission Card
        _buildPermissionCard(
          context: context,
          title: 'Usage Access',
          description: 'Enables UsageStatsManager to monitor exact app usage time and detect limit breaches.',
          isGranted: permissions.hasUsageStats,
          icon: Icons.timer_outlined,
          onAction: () async {
            await engine.requestUsageAuthorization();
            ref.invalidate(permissionsStatusProvider);
          },
        ),

        // 2. Overlay Permission Card
        _buildPermissionCard(
          context: context,
          title: 'Display Over Other Apps',
          description: 'Allows FocusGuard to present the full-screen restriction shield when a limit is exceeded.',
          isGranted: permissions.hasOverlay,
          icon: Icons.layers_outlined,
          onAction: () async {
            await engine.requestOverlayAuthorization();
            ref.invalidate(permissionsStatusProvider);
          },
        ),

        // 3. Accessibility Service Card
        _buildPermissionCard(
          context: context,
          title: 'Foreground Detection Service',
          description: 'Provides instant detection when a restricted app is launched to protect your attention. Does NOT inspect screen contents.',
          isGranted: permissions.hasAccessibility,
          icon: Icons.accessibility_new_rounded,
          onAction: () async {
            await engine.requestAccessibilityAuthorization();
            ref.invalidate(permissionsStatusProvider);
          },
        ),

        // 4. Notifications Card
        _buildPermissionCard(
          context: context,
          title: 'Notifications',
          description: 'Delivers friendly alerts at 50% and 80% thresholds before restrictions take effect.',
          isGranted: permissions.hasNotifications,
          icon: Icons.notifications_active_outlined,
          onAction: () async {
            await engine.requestNotificationAuthorization();
            ref.invalidate(permissionsStatusProvider);
          },
        ),

        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: _completeOnboarding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(permissions.isFullyAuthorized ? 'Continue to FocusGuard' : 'Proceed to Dashboard'),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded, size: 18),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildPermissionCard({
    required BuildContext context,
    required String title,
    required String description,
    required bool isGranted,
    required IconData icon,
    required VoidCallback onAction,
  }) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: (isGranted ? AppColors.success : AppColors.primaryCyan).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: isGranted ? AppColors.success : AppColors.primaryCyan,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 2),
                    StatusBadge(
                      label: isGranted ? 'Granted' : 'Action Required',
                      color: isGranted ? AppColors.success : AppColors.warning,
                      icon: isGranted ? Icons.check_circle_outline : Icons.warning_amber_rounded,
                    ),
                  ],
                ),
              ),
              if (!isGranted)
                OutlinedButton(
                  onPressed: onAction,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    visualDensity: VisualDensity.compact,
                  ),
                  child: const Text('Grant'),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Text(description, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

