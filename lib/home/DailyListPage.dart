import 'package:daily/model/DailyItem.dart';
import 'package:flutter/material.dart';

class DailyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyListState();
  }
}

class _DailyListState extends State<DailyListPage> {
  List<DailyItem> stories;

  @override
  void initState() {
    super.initState();
    getDailyList();
  }

  @override
  Widget build(BuildContext context) {
    if (stories == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget listView = ListView.builder(
      itemCount: stories.length,
      itemBuilder: (context, position) {},
    );
    return new RefreshIndicator(child: listView, onRefresh: () {});
  }

  void getDailyList() {

  }
}
