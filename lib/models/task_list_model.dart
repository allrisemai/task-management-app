import 'package:task_management_app/models/task_model.dart';

class TaskList {
  final List<TaskModel> tasks;
  final int pageNumber;
  final int totalPages;

  TaskList({
    required this.tasks,
    required this.pageNumber,
    required this.totalPages,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) {
    final List<TaskModel> taskList = (json['tasks'] as List)
        .map((taskJson) => TaskModel.fromJson(taskJson))
        .toList();

    return TaskList(
      tasks: taskList,
      pageNumber: json['pageNumber'] ?? 0,
      totalPages: json['totalPages'] ?? 0,
    );
  }
}
