import 'package:flutter/material.dart';
import 'package:task_management_app/models/task_model.dart';
import 'package:task_management_app/utils/tab_list.dart';
import 'package:task_management_app/widgets/task_item.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.title});
  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Tab> _tabs = [];
  List<TaskModel> task = [
    TaskModel(
        id: '1',
        title: 'Read a book',
        description: 'Spend an hour reading a book for pleasure',
        createdAt: DateTime.now(),
        status: "TODO"),
    TaskModel(
        id: '2',
        title: 'Read a book',
        description: 'Spend an hour reading a book for pleasure',
        createdAt: DateTime.now(),
        status: "TODO"),
    TaskModel(
        id: '3',
        title: 'Read a book',
        description: 'Spend an hour reading a book for pleasure',
        createdAt: DateTime.now(),
        status: "TODO")
  ];
  // late TabController _tabController;
  @override
  void initState() {
    setState(() {
      _tabs = getTabs(3);
    });
    // _tabController = TabController(vsync: this, length: _tabs.length);
    super.initState();
  }

  List<Tab> getTabs(int count) {
    _tabs.clear();
    for (int i = 0; i < TabList.tabList.length; i++) {
      _tabs.add(Tab(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: Colors.redAccent, width: 1)),
          child: Align(
            alignment: Alignment.center,
            child: Text(TabList.tabList[i]),
          ),
        ),
      ));
    }
    return _tabs;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
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
                        overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent),
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
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w500),
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
            child: TabBarView(
              // controller: _tabController,
              children: [
                ListView.builder(
                  itemCount: task.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      task: task[index],
                    );
                  },
                ),
                Text('data2'),
                Text('data3'),
              ],
            ),
          )
          // floatingActionButton: FloatingActionButton(
          //   onPressed: _incrementCounter,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.add),
          // ),
          ),
    );
  }
}
