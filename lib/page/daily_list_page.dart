import 'package:daily/model/before_resp.dart';
import 'package:daily/model/daily_item.dart';
import 'package:daily/model/latest_resp.dart';
import 'package:daily/page/daily_detail_page.dart';
import 'package:daily/utils.dart';
import 'package:daily/widget/round_image.dart';
import 'package:flutter/material.dart';
import 'package:daily/api/api_manager.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

class DailyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyListState();
  }
}

class _DailyListState extends State<DailyListPage> {
  List itemList = List();
  DateTime date = DateTime.now();

  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    getDailyList();
  }

  @override
  Widget build(BuildContext context) {
    if (itemList.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget listView = ListView.separated(
      itemCount: itemList.length,
      itemBuilder: (context, position) => renderRow(position),
      separatorBuilder: (context, index) => Divider(
            height: 0,
            indent: 10,
          ),
    );

    return SmartRefresher(
      child: listView,
      controller: _refreshController,
      enablePullUp: true,
      onRefresh: (up) {
        if (up) {
          getDailyList().then((value) {
            _refreshController.sendBack(up, RefreshStatus.idle);
          });
        } else {
          getBeforeList().then((value) {
            _refreshController.sendBack(up, RefreshStatus.idle);
          });
        }
      },
    );
  }

  Future getDailyList() async {
    LatestDailyResp resp = await ApiManger.getInstance().latest();
    setState(() {
      date = DateTime.now();
      itemList.clear();
      itemList.addAll(resp.stories);
    });
  }

  Future getBeforeList() async {
    BeforeResp resp =
        await ApiManger.getInstance().before(Utils.formatDate(date));
    date = date.subtract(Duration(days: 1));
    setState(() {
      if (itemList != null) {
        itemList.add(resp.date);
        itemList.addAll(resp.stories);
      }
    });
  }

  Widget renderDailyItem(DailyItem item) {
    return InkWell(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => DailyDetailPage(id: item.id)),
        );
      },
      child: Row(
        children: <Widget>[
          Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  item.title,
                  style: TextStyle(
                    color: const Color(0xFF0a0a0a),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
              child: RoundImage(
                width: 80,
                height: 60,
                url: item.images[0],
                radius: 5,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget renderDateItem(String date) {
    date = Utils.formatData(date);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Colors.blue),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          date,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }

  Widget renderRow(int position) {
    var item = itemList[position];
    var itemContent;
    if (item is DailyItem) {
      itemContent = renderDailyItem(item);
    }
    if (item is String) {
      itemContent = renderDateItem(item);
    }
    return itemContent;
  }
}
