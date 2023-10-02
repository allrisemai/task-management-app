import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/widgets/task_item.dart';

class TaskListView extends StatelessWidget {
  final RxList<TaskModel> tasks;
  const TaskListView({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
