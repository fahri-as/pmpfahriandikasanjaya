import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pmpfahriandikasanjaya/main.dart';
import 'package:pmpfahriandikasanjaya/presentation/login_screen/login_screen.dart';
import 'package:pmpfahriandikasanjaya/presentation/dashboard_screen/dashboard_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Logout functionality test', (WidgetTester tester) async {
    // Set up mock SharedPreferences
    SharedPreferences.setMockInitialValues({'token': 'dummy_token'});

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify if Dashboard screen is displayed
    expect(find.byType(DashboardScreen), findsOneWidget);

    // Tap logout button (AppbarTrailingImage)
    await tester.tap(find.byType(AppbarTrailingImage));
    await tester.pumpAndSettle();

    // Verify if returned to login screen
    expect(find.byType(LoginScreen), findsOneWidget);
  });
}
