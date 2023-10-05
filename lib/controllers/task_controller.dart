import 'package:get/get.dart';
import 'package:task_management_app/models/task_list_model.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/services/tasks_service.dart';

class TaskController extends GetxController {
  Rx<TaskInfo> tasksTodo =
      TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 0).obs;
  Rx<TaskInfo> tasksDoing =
      TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 0).obs;
  Rx<TaskInfo> tasksDone =
      TaskInfo(tasks: <TaskModel>[].obs, pageNumber: 0, totalPages: 0).obs;
  RxBool isTodoLoading = true.obs;
  RxBool isDoingLoading = true.obs;
  RxBool isDoneLoading = true.obs;
  RxBool isFetchNewData = false.obs;

  void updateTaskInfo(Rx<TaskInfo> taskInfo, TaskInfo newValue) {
    taskInfo.value.pageNumber = newValue.pageNumber + 1;
    taskInfo.value.totalPages = newValue.totalPages;
    taskInfo.value.tasks.addAll(newValue.tasks);
    taskInfo.refresh();
  }

  Future<void> fetchTasks(String status) async {
    TasksService request = TasksService();

    switch (status) {
      case 'TODO':
        isFetchNewData = true.obs;
        await request
            .getTaskList(offset: tasksTodo.value.pageNumber, status: status)
            .then((value) {
          if (value != null) {
            updateTaskInfo(tasksTodo, value);
            isTodoLoading = false.obs;
            isFetchNewData = false.obs;
          }
        }).catchError((onError) {
          printError();
        });

        break;
      case 'DOING':
        isFetchNewData = true.obs;
        request
            .getTaskList(offset: tasksDoing.value.pageNumber, status: status)
            .then((value) {
          if (value != null) {
            updateTaskInfo(tasksDoing, value);
            isDoingLoading = false.obs;
            isFetchNewData = false.obs;
          }
        }).catchError((onError) {
          printError();
        });
        break;
      case 'DONE':
        isFetchNewData = true.obs;
        request
            .getTaskList(offset: tasksDone.value.pageNumber, status: status)
            .then((value) {
          if (value != null) {
            updateTaskInfo(tasksDone, value);
            isDoneLoading = false.obs;
            isFetchNewData = false.obs;
          }
        }).catchError((onError) {
          printError();
        });
        break;
    }
  }

  Future<void> deleteTask(String id, String status) async {
    switch (status) {
      case "TODO":
        tasksTodo.value.tasks.removeWhere((item) => item.id == id);
        tasksTodo.refresh();
        break;
      case "DOING":
        tasksDoing.value.tasks.removeWhere((item) => item.id == id);
        tasksDoing.refresh();
        break;
      case "DONE":
        tasksDone.value.tasks.removeWhere((item) => item.id == id);
        tasksDone.refresh();
        break;
      default:
    }
  }
}
