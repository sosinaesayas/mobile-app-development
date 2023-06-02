import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/presentation/pages/company.dart/company_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('should clear user preferences on button press',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Logout(key: Key('logout')),
        ),
      ),
    );

    // Tap the Logout button
    await tester.tap(find.text('Log out'));
    await tester.pump();

    // Verify that user preferences are cleared
    SharedPreferences prefs = await SharedPreferences.getInstance();
    expect(prefs.getKeys(), isEmpty);
  });
}
