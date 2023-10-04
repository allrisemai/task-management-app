import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/controllers/task_controller.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/widgets/skeleton_loading/task_list_view_skeleton.dart';
import 'package:task_management_app/widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  final RxList<TaskModel> tasks;
  final RxBool isLoading;
  final ScrollController controller;
  const TaskListView(
      {super.key,
      required this.tasks,
      required this.isLoading,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());
    return isLoading.isTrue
        ? const TaskListViewSkeleton()
        : Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 30.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      bool isSameDate = true;
                      final DateTime date = tasks[index].createdAt;
                      if (index == 0) {
                        isSameDate = false;
                      } else {
                        final DateTime prevDate = tasks[index - 1].createdAt;
                        isSameDate = date.isSameDate(prevDate);
                      }
                      if (index == 0 || !(isSameDate)) {
                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Text(
                                  date.formatDate(),
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ),
                              TaskItem(
                                task: tasks[index],
                              )
                            ]);
                      } else {
                        return TaskItem(
                          task: tasks[index],
                        );
                      }
                    },
                  ),
                ),
                taskController.isFetchNewData.isTrue
                    ? const Text("loading data..")
                    // const Expanded(child: TaskListViewSkeleton())
                    : const SizedBox()
              ],
            ),
          );
  }
}

const String dateFormatter = 'MMMM dd, y';

extension DateHelper on DateTime {
  String formatDate() {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
