import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/presentation/pages/post_jobs.dart';
import 'package:jobportal/presentation/views/post_body.dart';

void main() {
  testWidgets('should show the PostBody widget', (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostJobWidget(),
        ),
      ),
    );

    // Verify that the widget shows the PostBody widget
    expect(find.byType(PostBody), findsOneWidget);
  });
}
