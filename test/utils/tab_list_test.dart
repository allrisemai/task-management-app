import 'package:flutter_test/flutter_test.dart';
import 'package:task_management_app/utils/tab_list.dart';

void main() {
  group('TabList Tests', () {
    test('TabList.tabList should contain the correct number of tabs', () {
      expect(TabList.tabList, isNotNull);
      expect(TabList.tabList, isNotEmpty);
      expect(TabList.tabList, hasLength(3));
    });

    test('TabList.tabList should contain the correct tab names', () {
      final tabNames = TabList.tabList.map((tab) => tab.tabName).toList();
      expect(tabNames, contains('To-do'));
      expect(tabNames, contains('Doing'));
      expect(tabNames, contains('Done'));
    });
  });
}
