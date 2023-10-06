import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/controllers/task_controller.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/screens/task_detail_screen.dart';

class TaskItem extends StatelessWidget {
  final TaskModel task;
  const TaskItem({
    super.key,
    required this.task,
  });

  @override
  Widget build(BuildContext context) {
    TaskController taskController = Get.put(TaskController());
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TaskDetailScreen(task: task)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
        margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: (_) =>
                    taskController.deleteTask(task.id, task.status),
                icon: Icons.delete_rounded,
                backgroundColor: const Color(0xFFFE4A49),
              )
            ],
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            title: Text(
              task.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(color: Theme.of(context).primaryColor),
            ),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: task.status == "TODO"
                          ? Colors.lightBlue
                          : task.status == "DOING"
                              ? Colors.amber
                              : Colors.green,
                      shape: BoxShape.circle),
                  child: Icon(
                      task.status == "TODO"
                          ? Icons.circle_rounded
                          : task.status == "DOING"
                              ? Icons.pending_rounded
                              : Icons.check_circle_rounded,
                      color: Colors.white
                      // color: task.status == "TODO" ? Colors.amber : Colors.deepOrange,
                      ),
                ),
              ],
            ),
            // trailing: const Icon(
            //   Icons.arrow_forward_ios,
            //   color: Colors.black26,
            //   size: 15,
            // ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.description,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .apply(color: Colors.black45),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      color: Colors.black45,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      DateFormat.Hm().format(task.createdAt),
                      style: Theme.of(context).textTheme.bodyLarge!.apply(
                            color: Colors.black45,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
