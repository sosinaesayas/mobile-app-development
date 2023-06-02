import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:jobportal/application/user/bloc/user_bloc.dart';
import 'package:jobportal/presentation/pages/company.dart/chome.dart';


void main() {
  group('CompanyHome', () {
    late Widget testWidget;
    late BuildContext context;

    setUp(() {
      testWidget = MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<FreelancerBloc>(
              create: (context) => FreelancerBloc(),
            ),
          ],
          child: CompanyHome(),
        ),
      );
    });

    testWidgets('renders app bar title correctly', (tester) async {
      await tester.pumpWidget(testWidget);
      context = tester.element(find.text('አfalagi'));
      expect(context, isNotNull);
    });

    testWidgets('tapping search button toggles search field', (tester) async {
      await tester.pumpWidget(testWidget);
      expect(find.byType(TextField), findsNothing);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      expect(find.byType(TextField), findsOneWidget);

      await tester.tap(find.byIcon(Icons.search));
      await tester.pump();
      expect(find.byType(TextField), findsNothing);
    });
  });
}
