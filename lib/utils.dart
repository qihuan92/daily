import 'dart:convert';
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

  static String loadHtmlWithCss(
      {String headImg, String html, List<String> cssUrlList}) {
    StringBuffer res = StringBuffer();
    res.write(
        // "<img src=\"$headImg\" alt=\"headImg\" height=\"200\" style=\"max-width:100%;overflow:hidden;\" />");
        "<img src=\"$headImg\" alt=\"headImg\" height=\"200\" width=\"100%\" />");
    cssUrlList.forEach((cssUrl) {
      res.write("<link href='$cssUrl' type=\"text/css\" rel=\"stylesheet\" />");
    });
    res.write(html.replaceAll(
      "class=\"img-place-holder\"",
      "class=\"img-place-holder-ignored\"",
    ));
    return Uri.dataFromString(
      res.toString(),
      mimeType: 'text/html',
      encoding: utf8,
    ).toString();
  }
}
