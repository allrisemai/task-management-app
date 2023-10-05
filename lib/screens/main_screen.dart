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
  final _scrollController = ScrollController();
  TaskController taskController = Get.put(TaskController());
  late TabController _tabController;
  String _seletecTab = TabList.tabList[0];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: TabList.tabList.length);
    _tabController.addListener(_handleChangeTab);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await taskController.fetchTasks(_seletecTab);
      _scrollController.addListener(_loadMoreData);
    });

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();

    super.dispose();
  }

  void _handleChangeTab() {
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

  void _loadMoreData() async {
    if ((_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) &&
        (taskController.tasksTodo.value.pageNumber <=
            taskController.tasksTodo.value.totalPages) &&
        taskController.isFetchNewData.isFalse) {
      await taskController.fetchTasks(_seletecTab);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TabList.tabList.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 110.0,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Column(
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
                color: Theme.of(context).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(50.0),
              ),
              width: MediaQuery.of(context).size.width * 0.8,
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
        body: Obx(() {
          return TabBarView(
            controller: _tabController,
            children: [
              TaskListView(
                tasks: taskController.tasksTodo.value.tasks,
                isLoading: taskController.isTodoLoading,
                controller: _scrollController,
              ),
              TaskListView(
                tasks: taskController.tasksDoing.value.tasks,
                isLoading: taskController.isDoingLoading,
                controller: _scrollController,
              ),
              TaskListView(
                tasks: taskController.tasksDone.value.tasks,
                isLoading: taskController.isDoneLoading,
                controller: _scrollController,
              ),
            ],
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {},
          tooltip: 'Add tasks',
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
