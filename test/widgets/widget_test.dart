import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_management_app/controllers/task_controller.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/screens/task_detail_screen.dart';
import 'package:task_management_app/utils/session.dart';
import 'package:task_management_app/utils/session_manager.dart';
import 'package:task_management_app/widgets/skeleton_loading/task_list_view_skeleton.dart';
import 'package:task_management_app/widgets/task_item.dart';
import 'package:task_management_app/widgets/task_list_view.dart';

void main() {
  testWidgets('TaskListViewSkeleton widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: TaskListViewSkeleton(),
    ));

    expect(find.byType(Shimmer), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(Row), findsNWidgets(6));
  });

  testWidgets('TaskItem widget test', (WidgetTester widgetTester) async {
    final task = TaskModel(
      id: '1',
      title: 'Test Task',
      description: 'This is a test task description.',
      status: 'TODO',
      createdAt: DateTime.now(),
    );

    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: TaskItem(
            task: task,
          ),
        ),
      ),
    );

    expect(find.text('Test Task'), findsOneWidget);
    expect(find.text('This is a test task description.'), findsOneWidget);
    expect(find.byType(Slidable), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });

  group("TaskListView widget test", () {
    final taskController = TaskController();
    List<TaskModel> tasks = [
      TaskModel(
        id: '1',
        title: 'Test Task',
        description: 'This is a test task description.',
        status: 'TODO',
        createdAt: DateTime.now(),
      ),
    ];
    final allTasks = RxList<TaskModel>.of(tasks);

    final controller = ScrollController();
    testWidgets("TaskListView widget test: isLoading is true",
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskListView(
              tasks: allTasks,
              isLoading: true.obs,
              controller: controller,
            ),
          ),
        ),
      );
      expect(find.byType(TaskListViewSkeleton), findsOneWidget);
    });
    testWidgets('TaskListView widget test: show list of TaskItem',
        (WidgetTester widgetTester) async {
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TaskListView(
              tasks: allTasks,
              isLoading: false.obs,
              controller: controller,
            ),
          ),
        ),
      );

      expect(find.byType(TaskItem), findsNWidgets(tasks.length));

      // Tap on a TaskItem: to push the TaskDetailScreen
      await widgetTester.tap(find.byType(TaskItem).first);
      await widgetTester.pumpAndSettle();
      expect(find.byType(TaskDetailScreen), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      // Tap on a ElevatedButton: to pop the TaskDetailScreen
      await widgetTester.tap(find.byType(ElevatedButton));
      await widgetTester.pumpAndSettle();
      expect(find.byType(TaskDetailScreen), findsNothing);

      taskController.dispose();
    });
  });

  testWidgets('SessionManager widget test', (WidgetTester tester) async {
    StreamController streamController = StreamController();

    await tester.pumpWidget(
      MaterialApp(
        home: Builder(builder: (context) {
          Session session = Session();
          session.startListener(
              streamController: streamController, context: context);
          return SessionManager(
            streamController: StreamController(),
            duration: const Duration(seconds: 1),
            context: context,
            child: const SizedBox(),
          );
        }),
      ),
    );
    expect(find.byType(SessionManager), findsOneWidget);
  });

  group('Session Tests', () {
    Session session = Session();
    StreamController streamController = StreamController();
    testWidgets("startListener should enable the session timer",
        (WidgetTester widgetTester) async {
      Session session = Session();
      StreamController streamController = StreamController();
      await widgetTester
          .pumpWidget(MaterialApp(home: Material(child: Container())));
      final BuildContext context = widgetTester.element(find.byType(Container));
      session.startListener(
        streamController: streamController,
        context: context,
      );

      expect(session.streamController, equals(streamController));
      expect(session.context, isNotNull);

      streamController.stream.listen((event) {
        expect(event, isA<Map<String, dynamic>>());
        expect(event['timer'], isTrue);
      });
    });
    testWidgets("stopListener should disable the session timer",
        (WidgetTester widgetTester) async {
      await widgetTester
          .pumpWidget(MaterialApp(home: Material(child: Container())));
      final BuildContext context = widgetTester.element(find.byType(Container));

      session.stopListener(
        streamController: streamController,
        context: context,
      );

      expect(session.streamController, equals(streamController));
      expect(session.context, isNotNull);

      streamController.stream.listen((event) {
        expect(event, isA<Map<String, dynamic>>());
        expect(event['timer'], isFalse);
      });
    });
  });
}
