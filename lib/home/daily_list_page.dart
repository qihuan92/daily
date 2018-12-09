import 'package:daily/home/daily_detail_page.dart';
import 'package:daily/model/daily_item.dart';
import 'package:daily/model/latest_resp.dart';
import 'package:flutter/material.dart';
import 'package:daily/api/api_manager.dart';

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
      itemBuilder: (context, position) => renderRow(position),
    );
    return RefreshIndicator(
        child: listView,
        onRefresh: () async {
          return getDailyList();
        });
  }

  void getDailyList() async {
    LatestDailyResp resp = await ApiManger.getInstance().latest();
    setState(() {
      stories = resp.stories;
    });
  }

  Widget renderRow(int position) {
    DailyItem item = stories[position];
    var content = Row(
      children: <Widget>[
        Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                item.title,
                style:
                    TextStyle(color: const Color(0xFF0a0a0a), fontSize: 15.0),
              ),
            )),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, right: 15.0),
          child: Center(
            child: Image.network(item.images[0]),
          ),
        ))
      ],
    );

    var card = Card(
      elevation: 2.0,
      margin:
          const EdgeInsets.only(left: 12.0, top: 6.0, bottom: 6.0, right: 12.0),
      child: content,
    );

    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DailyDetailPage(
                  item.id,
                )));
      },
      child: card,
    );
  }
}
