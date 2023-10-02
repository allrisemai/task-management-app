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
      title: Text(
        task.title,
        // maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: Theme.of(context)
            .textTheme
            .titleSmall!
            .apply(color: Theme.of(context).primaryColor),
      ),
      leading: Icon(
        Icons.check_circle_outline_rounded,
        color: task.status == "TODO" ? Colors.amber : Colors.deepOrange,
      ),
      subtitle: Text(
        task.description,
        style:
            Theme.of(context).textTheme.bodyLarge!.apply(color: Colors.black45),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
