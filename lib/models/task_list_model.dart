import 'package:get/get.dart';
import 'package:task_management_app/models/task_model.dart';

class TaskInfo {
  RxList<TaskModel> tasks;
  int pageNumber;
  int totalPages;

  TaskInfo({
    required this.tasks,
    required this.pageNumber,
    required this.totalPages,
  });

  factory TaskInfo.fromJson(Map<String, dynamic> json) {
    final List<TaskModel> taskList = (json['tasks'] as List)
        .map((taskJson) => TaskModel.fromJson(taskJson))
        .toList();

    return TaskInfo(
      tasks: taskList.obs,
      pageNumber: json['pageNumber'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}
