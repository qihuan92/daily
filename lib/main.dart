import 'package:daily/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  // 初始化 intl 的默认语言
  initializeDateFormatting('zh_CN');
  runApp(HomePage());
}
