import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/app.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/route_constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Transparent status bar for immersive dark aesthetic
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Color(0xFF111D4A),
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final isFirstLaunchDone = prefs.getBool(AppConstants.keyFirstLaunch) ?? false;
  final initialRoute = isFirstLaunchDone ? AppRoutes.dashboard : AppRoutes.onboarding;

  runApp(
    ProviderScope(
      child: FocusGuardApp(initialRoute: initialRoute),
    ),
  );
}
