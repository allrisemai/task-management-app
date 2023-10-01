import 'package:flutter/material.dart';
import 'package:task_management_app/models/task_model.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // width: double.infinity,
      // padding: const EdgeInsets.all(10.0),
      // decoration: BoxDecoration(
      //   // color: Theme.of(context).colorScheme.inversePrimary,
      //   borderRadius: BorderRadius.circular(10.0),
      // ),
      title: Text(
        task.title,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .apply(color: Theme.of(context).primaryColor),
      ),
      leading: const Icon(Icons.check_circle_outline_rounded),
      subtitle: Text(
        task.description,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .apply(color: Colors.black26),
      ),
    );
  }
}
