import 'package:get/get.dart';
import 'package:task_management_app/models/task_list_model.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/services/tasks_service.dart';

class TaskController extends GetxController {
  // RxList<TaskModel> tasks = <TaskModel>[].obs;
  Rx<TaskInfo> tasksTodo =
      TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 0).obs;
  Rx<TaskInfo> tasksDoing =
      TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 0).obs;
  Rx<TaskInfo> tasksDone =
      TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 0).obs;

  void updateTaskInfo(Rx<TaskInfo> taskInfo, TaskInfo newValue) {
    taskInfo.value.pageNumber = newValue.pageNumber + 1;
    taskInfo.value.totalPages = newValue.totalPages;
    taskInfo.value.tasks.addAll(newValue.tasks);
    taskInfo.refresh();
  }

  void fetchTasks(String status) {
    TasksService request = TasksService();

    switch (status) {
      case 'TODO':
        request
            .getTaskList(offset: tasksTodo.value.pageNumber, status: status)
            .then((value) {
          if (value != null) updateTaskInfo(tasksTodo, value);
        }).catchError((onError) {
          printError();
        });

        break;
      case 'DOING':
        request
            .getTaskList(offset: tasksDoing.value.pageNumber, status: status)
            .then((value) {
          if (value != null) updateTaskInfo(tasksDoing, value);
        }).catchError((onError) {
          printError();
        });
        break;
      case 'DONE':
        request
            .getTaskList(offset: tasksDone.value.pageNumber, status: status)
            .then((value) {
          if (value != null) updateTaskInfo(tasksDone, value);
        }).catchError((onError) {
          printError();
        });
        break;
    }
  }

  void deleteTask(String id) {}
}
