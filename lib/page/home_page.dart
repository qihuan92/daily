import 'package:daily/const.dart';
import 'package:daily/page/daily_list_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: app_name,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(title: Text(app_name)),
        body: DailyListPage(),
      ),
    );
  }
}
