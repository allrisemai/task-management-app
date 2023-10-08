import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart' hide Response;
import 'package:mockito/mockito.dart';
import 'package:task_management_app/controllers/tab_controller.dart';
import 'package:task_management_app/controllers/task_controller.dart';
import 'package:task_management_app/models/tab_model.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/services/dio_client.dart';
import 'package:task_management_app/services/tasks_service.dart';

class MockDioClient extends Mock implements DioClient {}

class MockTaskService extends Mock implements TasksService {}

void main() {
  group('MyTabController Tests', () {
    late MyTabController myTabController;

    setUp(() {
      Get.testMode = true;
      myTabController = MyTabController();
    });

    tearDown(() {
      myTabController.dispose();
    });

    test('onTabChange should change the current tab', () async {
      final newTab = TabModel(id: 'NEW_TAB', tabName: 'New Tab');
      await myTabController.onTabChange(newTab);
      expect(myTabController.currentTab.value, newTab);
    });

    test('onInit should set the current tab to the first tab', () {
      final firstTab = myTabController.tabList[0];
      expect(myTabController.currentTab.value, firstTab);
    });
  });
  group('TaskController Tests', () {
    TaskController taskController = TaskController();
    TasksService tasksService = TasksService();
    MockDioClient mockDioClient = MockDioClient();

    setUp(() {
      Get.testMode = true;
      mockDioClient = MockDioClient();
      taskController = TaskController();
      taskController.request = tasksService;
      tasksService.dio = mockDioClient;
    });

    tearDown(() {
      Get.reset(); // Reset the GetX dependencies after each test
    });

    test('deleteTask: should remove a task from list', () async {
      const status = 'TODO';
      const taskIdToDelete = '1';

      taskController.tasksTodo.value.tasks.addAll([
        TaskModel(
          id: '1',
          title: 'Task 1',
          description: 'Description 1',
          createdAt: DateTime.now(),
          status: 'TODO',
        ),
        TaskModel(
          id: '2',
          title: 'Task 2',
          description: 'Description 2',
          createdAt: DateTime.now(),
          status: 'TODO',
        ),
      ]);

      await taskController.deleteTask(taskIdToDelete, status);

      expect(taskController.tasksTodo.value.tasks.length, 1);
      expect(
        taskController.tasksTodo.value.tasks
            .any((task) => task.id == taskIdToDelete),
        isFalse,
      );
    });
  });
}
