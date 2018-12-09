import 'package:daily/const.dart';
import 'package:daily/home/daily_list_page.dart';
import 'package:flutter/material.dart';

class DailyDetailPage extends StatefulWidget {
  int id;

  DailyDetailPage(this.id);

  @override
  State<StatefulWidget> createState() {
    return _DailyDetailState();
  }
}

class _DailyDetailState extends State<DailyDetailPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(app_name)),
      ),
    );
  }
}
