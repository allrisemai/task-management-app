import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/task_controller.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/utils/date_utils.dart';
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
        : Obx(() {
            return Padding(
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
                          isSameDate = DateHelper.isSameDate(prevDate, date);
                        }
                        if (index == 0 || !(isSameDate)) {
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 10.0),
                                  child: Text(
                                    DateHelper.formatDate(date),
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .apply(color: Colors.black87),
                                  ),
                                ),
                                TaskItem(
                                  key: Key('TaskItem_${tasks[index].status}'),
                                  task: tasks[index],
                                )
                              ]);
                        } else {
                          return TaskItem(
                            key: Key('TaskItem_${tasks[index].status}'),
                            task: tasks[index],
                          );
                        }
                      },
                    ),
                  ),
                  taskController.isFetchNewData.value
                      ? Container(
                          padding: const EdgeInsets.only(
                            top: 15.0,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
            );
          });
  }
}
