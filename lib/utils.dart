import 'package:intl/intl.dart';

class Utils {
  static const String _zhihuFormat = 'yyyyMMdd';

  static String formatDate(DateTime date) {
    return DateFormat(_zhihuFormat).format(date);
  }

  static String formatData(String date) {
    DateTime dateTime = DateTime.parse(date);
    return DateFormat.yMMMd('zh_CN').add_EEEE().format(dateTime);
  }

  static String today() {
    return DateFormat(_zhihuFormat).format(DateTime.now());
  }
}
