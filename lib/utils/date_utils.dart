import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String dateFormatter = 'MMMM dd, y';

  static String formatDate(DateTime dateTime) {
    final formatter = DateFormat(dateFormatter);
    return formatter.format(dateTime);
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
