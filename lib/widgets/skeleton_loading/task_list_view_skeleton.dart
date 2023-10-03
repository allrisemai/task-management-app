import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TaskListViewSkeleton extends StatelessWidget {
  const TaskListViewSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  width: 50,
                  height: 50,
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        width: double.infinity,
                        height: 15,
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        width: double.infinity * 0.5,
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
