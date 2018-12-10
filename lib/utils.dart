import 'package:intl/intl.dart';

class Utils {
  static const String _zhihuFormat = 'yyyyMMdd';

  static String formatDate(DateTime date) {
    return DateFormat(_zhihuFormat).format(date);
  }

  static String today() {
    return DateFormat(_zhihuFormat).format(DateTime.now());
  }
}
