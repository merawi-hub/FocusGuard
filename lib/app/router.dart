import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/route_constants.dart';
import '../features/analytics/presentation/analytics_screen.dart';
import '../features/app_limits/presentation/app_limit_config_screen.dart';
import '../features/app_limits/presentation/app_limits_screen.dart';
import '../features/app_monitoring/presentation/app_monitoring_screen.dart';
import '../features/daily_routines/presentation/daily_routines_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/focus_mode/presentation/focus_mode_screen.dart';
import '../features/onboarding/presentation/onboarding_screen.dart';
import '../features/restrictions/presentation/restrictions_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../shared/models/platform_app.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter createRouter({required String initialLocation}) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const OnboardingScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithNav(child: child);
        },
        routes: [
          GoRoute(
            path: AppRoutes.dashboard,
            pageBuilder: (context, state) => const NoTransitionPage(child: DashboardScreen()),
          ),
          GoRoute(
            path: AppRoutes.appMonitoring,
            pageBuilder: (context, state) => const NoTransitionPage(child: AppMonitoringScreen()),
          ),
          GoRoute(
            path: AppRoutes.appLimits,
            pageBuilder: (context, state) => const NoTransitionPage(child: AppLimitsScreen()),
          ),
          GoRoute(
            path: AppRoutes.analytics,
            pageBuilder: (context, state) => const NoTransitionPage(child: AnalyticsScreen()),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.appLimitConfig,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final app = state.extra as PlatformApp;
          return AppLimitConfigScreen(app: app);
        },
      ),
      GoRoute(
        path: AppRoutes.restrictions,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const RestrictionsScreen(),
      ),
      GoRoute(
        path: AppRoutes.focusMode,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const FocusModeScreen(),
      ),
      GoRoute(
        path: AppRoutes.dailyRoutines,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const DailyRoutinesScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
  );
}

class ScaffoldWithNav extends StatelessWidget {
  final Widget child;

  const ScaffoldWithNav({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith(AppRoutes.appMonitoring)) {
      return 1;
    }
    if (location.startsWith(AppRoutes.appLimits)) {
      return 2;
    }
    if (location.startsWith(AppRoutes.analytics)) {
      return 3;
    }
    if (location == AppRoutes.dashboard) {
      return 0;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(AppRoutes.dashboard);
        break;
      case 1:
        context.go(AppRoutes.appMonitoring);
        break;
      case 2:
        context.go(AppRoutes.appLimits);
        break;
      case 3:
        context.go(AppRoutes.analytics);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (idx) => _onItemTapped(idx, context),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.shield_outlined),
            selectedIcon: Icon(Icons.shield_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.apps_outlined),
            selectedIcon: Icon(Icons.apps_rounded),
            label: 'Catalog',
          ),
          NavigationDestination(
            icon: Icon(Icons.tune_outlined),
            selectedIcon: Icon(Icons.tune_rounded),
            label: 'Limits',
          ),
          NavigationDestination(
            icon: Icon(Icons.insights_outlined),
            selectedIcon: Icon(Icons.insights_rounded),
            label: 'Analytics',
          ),
        ],
      ),
    );
  }
}

