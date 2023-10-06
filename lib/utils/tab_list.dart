import 'package:task_management_app/models/tab_model.dart';

class TabList {
  TabList._();

  static List<TabModel> tabList = [
    TabModel(
      id: "TODO",
      tabName: "To-do",
    ),
    TabModel(
      id: "DOING",
      tabName: "Doing",
    ),
    TabModel(
      id: "DONE",
      tabName: "Done",
    )
  ];
}
