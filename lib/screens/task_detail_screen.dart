import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/utils/date_utils.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;
  const TaskDetailScreen({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Detail"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        titleTextStyle: const TextStyle(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.status,
                        style: Theme.of(context).textTheme.titleSmall!.apply(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateHelper.formatDate(task.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(color: Colors.black54),
                          ),
                          Text(
                            DateFormat.Hm().format(task.createdAt),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(color: Colors.black54),
                          ),
                        ],
                      ),
                      const Divider(
                        height: 30,
                      ),
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.titleMedium!.apply(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      Text(
                        task.description,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Material(
              elevation: 2,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 30.0),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary),
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
