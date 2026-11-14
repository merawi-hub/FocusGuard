import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:focusguard/app/app.dart';
import 'package:focusguard/core/constants/route_constants.dart';
import 'package:focusguard/core/platform/restriction_engine_provider.dart';
import 'package:focusguard/shared/models/permission_status.dart';

void main() {
  testWidgets('FocusGuardApp renders onboarding screen with permissions', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          permissionsStatusProvider.overrideWith((ref) async => const PlatformPermissionsStatus(
                hasUsageStats: true,
                hasOverlay: true,
                hasAccessibility: false,
                hasNotifications: true,
              )),
        ],
        child: const FocusGuardApp(initialRoute: AppRoutes.onboarding),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Welcome to FocusGuard'), findsOneWidget);
    expect(find.text('Required Android Permissions'), findsOneWidget);
    expect(find.text('Usage Access'), findsOneWidget);
  });
}
