import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:task_management_app/utils/date_utils.dart';

void main() {
  group("DateHelper model test", () {
    testWidgets('DateHelper test: formatDate', (WidgetTester tester) async {
      DateTime date = DateTime(2023, 03, 10);
      String dateFormat = DateHelper.formatDate(date);

      expect(dateFormat, DateFormat(DateHelper.dateFormatter).format(date));
    });
    testWidgets('DateHelper test: isSameDate is false',
        (WidgetTester tester) async {
      DateTime date1 = DateTime(2023, 03, 10);
      DateTime date2 = DateTime(2023, 03, 3);
      bool isSameDate = DateHelper.isSameDate(date1, date2);

      expect(isSameDate, false);
    });
    testWidgets('DateHelper test: isSameDate is true',
        (WidgetTester tester) async {
      DateTime date1 = DateTime(2023, 03, 3);
      DateTime date2 = DateTime(2023, 03, 3);
      bool isSameDate = DateHelper.isSameDate(date1, date2);

      expect(isSameDate, true);
    });
  });
}
