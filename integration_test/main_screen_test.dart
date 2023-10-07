import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:task_management_app/main.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("end to end testing", () {
    testWidgets('Verify that changing tab works correctly',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();
      expect(find.text("My Tasks"), findsOneWidget);
      expect(find.byKey(const Key('TaskItem_TODO')), findsAtLeastNWidgets(1));

      await widgetTester.tap(find.byKey(const Key('tab_DOING')));
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();
      expect(find.byKey(const Key('TaskItem_DOING')), findsAtLeastNWidgets(1));

      await widgetTester.tap(find.byKey(const Key('tab_DONE')));
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();
      expect(find.byKey(const Key('TaskItem_DONE')), findsAtLeastNWidgets(1));
    });

    testWidgets('Verify that the passcode is shown after 10 seconds',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await Future.delayed(const Duration(seconds: 10));
      await widgetTester.pumpAndSettle();
      expect(find.text('Please enter your passcode'), findsOneWidget);
    });

    testWidgets(
        'Verify that the Task Detail Screen will be shown after clicking on TaskItem',
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byKey(const Key('TaskItem_TODO')).first);
      await Future.delayed(const Duration(seconds: 1));
      await widgetTester.pumpAndSettle();
      expect(find.text('Task Detail'), findsOneWidget);
    });

    testWidgets('Verify that task is deleted', (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());
      await Future.delayed(const Duration(seconds: 3));
      await widgetTester.pumpAndSettle();

      await widgetTester.drag(
          find.byKey(const Key('cbb0732a-c9ab-4855-b66f-786cd41a3cd1')),
          const Offset(-200, 0));
      await Future.delayed(const Duration(seconds: 1));
      await widgetTester.pumpAndSettle();
      await widgetTester.tap(find.byType(SlidableAction));
      await Future.delayed(const Duration(seconds: 2));
      await widgetTester.pumpAndSettle();

      expect(find.byKey(const Key('cbb0732a-c9ab-4855-b66f-786cd41a3cd1')),
          findsNothing);
    });
  });
}
