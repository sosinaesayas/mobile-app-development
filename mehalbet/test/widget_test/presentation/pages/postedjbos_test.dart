import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';

import 'package:jobportal/presentation/pages/postedjobs.dart';
import 'package:jobportal/presentation/views/list_of_jobs.dart';

void main() {
  testWidgets('should show the ListofJobs widget', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: PostedJobs(),
      ),
    );

    // Verify that the widget shows the ListofJobs widget
    expect(find.byType(ListofJobs), findsOneWidget);
  });
}
