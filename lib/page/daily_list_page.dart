import 'package:daily/model/before_resp.dart';
import 'package:daily/model/daily_item.dart';
import 'package:daily/model/latest_resp.dart';
import 'package:daily/page/daily_detail_page.dart';
import 'package:daily/utils.dart';
import 'package:daily/widget/round_image.dart';
import 'package:flutter/material.dart';
import 'package:daily/api/api_manager.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_swiper/flutter_swiper.dart';

class DailyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyListState();
  }
}

class _DailyListState extends State<DailyListPage> {
  List _itemList = List();
  DateTime _date = DateTime.now();

  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _getDailyList();
  }

  @override
  Widget build(BuildContext context) {
    if (_itemList.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    Widget listView = ListView.separated(
      itemCount: _itemList.length,
      itemBuilder: (context, index) => _renderRow(index),
      separatorBuilder: (context, index) => Divider(
            height: 0,
            indent: 10,
          ),
    );

    return SmartRefresher(
      child: listView,
      controller: _refreshController,
      enablePullUp: true,
      onRefresh: (up) => _refreshListener(up),
    );
  }

  void _refreshListener(bool up) async {
    if (up) {
      await _getDailyList();
    } else {
      await _getBeforeList();
    }
    _refreshController.sendBack(up, RefreshStatus.idle);
  }

  Future _getDailyList() async {
    LatestDailyResp resp = await ApiManger.getInstance().latest();
    setState(() {
      _date = DateTime.now();
      _itemList.clear();
      _itemList.add(resp.topStories);
      _itemList.addAll(resp.stories);
    });
  }

  Future _getBeforeList() async {
    BeforeResp resp =
        await ApiManger.getInstance().before(Utils.formatDate(_date));
    _date = _date.subtract(Duration(days: 1));
    setState(() {
      if (_itemList != null) {
        _itemList.add(resp.date);
        _itemList.addAll(resp.stories);
      }
    });
  }

  Widget _renderDailyItem(DailyItem item) {
    return InkWell(
      onTap: () async {
        _goDetail(item);
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

  void _goDetail(DailyItem item) async {
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => DailyDetailPage(id: item.id)),
    );
  }

  Widget _renderBanner(List<DailyItem> itemList) {
    return SizedBox(
      height: 200.0,
      child: Swiper(
        itemCount: itemList.length,
        itemBuilder: (context, index) => Image.network(
              itemList[index].image,
              fit: BoxFit.fill,
            ),
        pagination: SwiperPagination(),
        onTap: (index) async {
          _goDetail(itemList[index]);
        },
      ),
    );
  }

  Widget _renderDateItem(String date) {
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

  Widget _renderRow(int position) {
    var item = _itemList[position];
    var itemContent;
    if (item is List<DailyItem>) {
      itemContent = _renderBanner(item);
    }
    if (item is DailyItem) {
      itemContent = _renderDailyItem(item);
    }
    if (item is String) {
      itemContent = _renderDateItem(item);
    }
    return itemContent;
  }
}
