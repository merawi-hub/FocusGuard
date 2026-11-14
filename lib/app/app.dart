import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'router.dart';
import 'theme/theme.dart';
import '../core/constants/app_constants.dart';

final routerProvider = Provider.family<GoRouter, String>((ref, initialLocation) {
  return createRouter(initialLocation: initialLocation);
});

class FocusGuardApp extends ConsumerWidget {
  final String initialRoute;

  const FocusGuardApp({
    super.key,
    required this.initialRoute,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider(initialRoute));

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // FocusGuard Dark Navy is signature theme
      routerConfig: router,
    );
  }
}

