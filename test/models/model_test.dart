import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:task_management_app/models/tab_model.dart';
import 'package:task_management_app/models/task_info_model.dart';
import 'package:task_management_app/models/task_model.dart';

void main() {
  group("TaskInfo model test", () {
    testWidgets('TaskInfo model test: task is empty',
        (WidgetTester tester) async {
      final taskInfo =
          TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 2);

      expect(taskInfo.tasks.length, 0);
      expect(taskInfo.pageNumber, 0);
      expect(taskInfo.totalPages, 2);
    });
    testWidgets('TaskInfo model test: task is not empty',
        (WidgetTester tester) async {
      final taskInfo = TaskInfo(
          tasks: RxList([
            TaskModel(
                id: "123",
                title: "taskInfo test",
                description: "This is a taskInfo testing.",
                createdAt: DateTime.parse("2023-03-25T09:00:00Z"),
                status: "TODO")
          ]),
          pageNumber: 0,
          totalPages: 2);

      expect(taskInfo.tasks.length, 1);
      expect(taskInfo.pageNumber, 0);
      expect(taskInfo.totalPages, 2);
    });
  });

  group("Task model test", () {
    testWidgets("Task model test: ", (WidgetTester widgetTester) async {
      final taskModel = TaskModel(
          id: "123",
          title: "taskInfo test",
          description: "This is a taskInfo testing.",
          createdAt: DateTime.parse("2023-03-25T09:00:00Z"),
          status: "TODO");

      expect(taskModel.id, "123");
      expect(taskModel.title, "taskInfo test");
      expect(taskModel.description, "This is a taskInfo testing.");
      expect(taskModel.createdAt, DateTime.parse("2023-03-25T09:00:00Z"));
      expect(taskModel.status, "TODO");
    });
  });

  testWidgets("Tab model test: ", (WidgetTester widgetTester) async {
    final taskModel = TabModel(id: "123", tabName: "Test tab");

    expect(taskModel.id, "123");
    expect(taskModel.tabName, "Test tab");
  });
}
