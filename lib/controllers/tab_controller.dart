import 'package:get/get.dart';
import 'package:task_management_app/models/tab_model.dart';
import 'package:task_management_app/utils/tab_list.dart';

class MyTabController extends GetxController {
  RxList<TabModel> tabList = RxList<TabModel>.from(TabList.tabList);
  Rx<TabModel> currentTab = Rx<TabModel>(TabList.tabList[0]);

  @override
  void onInit() {
    super.onInit();
    currentTab.value = tabList[0];
  }

  Future<void> onTabChange(TabModel tab) async {
    currentTab.value = tab;
  }
}
