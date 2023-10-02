import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/controllers/task_controller.dart';
import 'package:task_management_app/utils/tab_list.dart';
import 'package:task_management_app/widgets/task_list_view.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  List<Tab> _tabsWidget = [];
  String _seletecTab = TabList.tabList[0];
  late TabController _tabController;
  TaskController taskController = Get.put(TaskController());

  @override
  void initState() {
    setState(() {
      _tabsWidget = getTabs(3);
    });
    taskController.fetchTasks(_seletecTab);
    _tabController = TabController(vsync: this, length: _tabsWidget.length);
    _tabController.addListener(handleChangeTab);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Tab> getTabs(int count) {
    _tabsWidget.clear();
    for (int i = 0; i < TabList.tabList.length; i++) {
      _tabsWidget.add(Tab(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.redAccent, width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(TabList.tabList[i].toLowerCase()),
          ),
        ),
      ));
    }
    return _tabsWidget;
  }

  void handleChangeTab() {
    setState(() {
      _seletecTab = TabList.tabList[_tabController.index];
    });

    switch (_seletecTab) {
      case "TODO":
        if (taskController.tasksTodo.value.tasks.isEmpty &&
            taskController.tasksTodo.value.pageNumber <=
                taskController.tasksTodo.value.totalPages) {
          taskController.fetchTasks(TabList.tabList[_tabController.index]);
        }
        break;
      case "DOING":
        if (taskController.tasksDoing.value.tasks.isEmpty &&
            taskController.tasksDoing.value.pageNumber <=
                taskController.tasksDoing.value.totalPages) {
          taskController.fetchTasks(TabList.tabList[_tabController.index]);
        }
        break;
      case "DONE":
        if (taskController.tasksDone.value.tasks.isEmpty &&
            taskController.tasksDone.value.pageNumber <=
                taskController.tasksDone.value.totalPages) {
          taskController.fetchTasks(TabList.tabList[_tabController.index]);
        }
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabsWidget.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          // bottomOpacity: 0.0,
          toolbarHeight: 110.0,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                'Check your tasks here',
                style: Theme.of(context).textTheme.bodySmall,
              )
            ],
          ),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20.0),
          )),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: Container(
              decoration: BoxDecoration(
                  // color: Colors.white,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius: BorderRadius.circular(50.0)),
              width: MediaQuery.of(context).size.width * 0.8,
              // transform: Matrix4.translationValues(0.0, 20.0, 0.0),
              child: Stack(
                children: [
                  SizedBox(
                    child: TabBar(
                      controller: _tabController,
                      overlayColor:
                          MaterialStateProperty.all<Color>(Colors.transparent),
                      tabs: TabList.tabList
                          .map((tab) => Tab(
                                text: tab,
                              ))
                          .toList(),
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: LinearGradient(
                            begin: const Alignment(-1, -1),
                            end: const Alignment(1, 1),
                            colors: [
                              Theme.of(context).colorScheme.secondary,
                              Theme.of(context).colorScheme.primary
                            ]),
                      ),
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.primary,
                      labelColor: Colors.white,
                      labelStyle: const TextStyle(fontWeight: FontWeight.w500),
                      indicatorSize: TabBarIndicatorSize.tab,
                      dividerColor: Colors.transparent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(
            vertical: 15.0,
          ),
          child: Obx(() {
            return TabBarView(
              controller: _tabController,
              children: [
                TaskListView(tasks: taskController.tasksTodo.value.tasks),
                TaskListView(tasks: taskController.tasksDoing.value.tasks),
                TaskListView(tasks: taskController.tasksDone.value.tasks),
              ],
            );
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            taskController.fetchTasks(_seletecTab);
          },
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
