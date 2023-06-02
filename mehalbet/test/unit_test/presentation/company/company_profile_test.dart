import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/presentation/pages/company.dart/company_profile.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('Logout', () {
    late Widget testWidget;
    late MockSharedPreferences mockSharedPreferences;

    setUp(() {
      mockSharedPreferences = MockSharedPreferences();
      testWidget = MaterialApp(
        home: Logout(),
      );
    });

    testWidgets('displays a "Log out" button', (tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.text('Log out'), findsOneWidget);
    });
  });
}
