import 'package:daily/model/base_model.dart';
import 'package:daily/model/before_resp.dart';
import 'package:daily/model/daily_item.dart';
import 'package:daily/model/latest_resp.dart';
import 'package:daily/page/daily_detail_page.dart';
import 'package:daily/utils.dart';
import 'package:daily/widget/loding_widget.dart';
import 'package:daily/widget/round_image.dart';
import 'package:flutter/material.dart';
import 'package:daily/api/api_manager.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:transparent_image/transparent_image.dart';

class DailyListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DailyListState();
  }
}

class _DailyListState extends State<DailyListPage> {
  List _itemList = List();
  DateTime _date = DateTime.now();
  bool _isLoading = true;
  bool _showError = false;
  String _errorMsg = '';

  RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _getDailyList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return _renderLoadingView();
    }
    if (_showError) {
      return _renderErrorView();
    }
    return SmartRefresher(
      child: ListView.separated(
        itemCount: _itemList.length,
        itemBuilder: (context, index) => _renderRow(index),
        separatorBuilder: (context, index) => Divider(height: 0, indent: 10),
      ),
      headerBuilder: (context, mode) => LoadingHeaderWidget(mode),
      footerBuilder: (context, mode) => LoadingFooterWidget(mode),
      controller: _refreshController,
      enablePullUp: true,
      onRefresh: (up) {
        if (up) {
          _getDailyList(manual: true);
        } else {
          _getBeforeList();
        }
      },
    );
  }

  void _getDailyList({bool manual = false}) async {
    BaseResp<LatestDailyResp> resp = await ApiManger().latest();
    if (manual) {
      _refreshController.sendBack(true, RefreshStatus.completed);
    }
    setState(() {
      _isLoading = false;
      _date = DateTime.now();
      _itemList.clear();
      _showError = !resp.success();
      if (resp.success()) {
        _itemList.add(resp.data.topStories);
        _itemList.addAll(resp.data.stories);
      } else {
        _errorMsg = resp.msg;
      }
    });
  }

  void _getBeforeList() async {
    BaseResp<BeforeResp> resp =
        await ApiManger().before(Utils.formatDate(_date));
    _date = _date.subtract(Duration(days: 1));
    _refreshController.sendBack(false, RefreshStatus.idle);
    setState(() {
      if (_itemList != null) {
        _itemList.add(resp.data.date);
        _itemList.addAll(resp.data.stories);
      }
    });
  }

  Widget _renderLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _renderErrorView() {
    return InkWell(
        onTap: () => _getDailyList(),
        child: SizedBox.expand(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.error,
                size: 50,
                color: Colors.black45,
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  _errorMsg,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _renderDailyItem(DailyItem item) {
    return InkWell(
      onTap: () => _goDetail(item),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                item.title,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
        itemBuilder: (context, index) => _renderBannerItem(itemList[index]),
        pagination: SwiperPagination(
          margin: EdgeInsets.all(5),
          builder: DotSwiperPaginationBuilder(
            size: 6,
            activeSize: 6,
          ),
        ),
        autoplay: true,
        onTap: (index) => _goDetail(itemList[index]),
      ),
    );
  }

  Widget _renderBannerItem(DailyItem item) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FadeInImage.memoryNetwork(
          image: item.image,
          placeholder: kTransparentImage,
          fit: BoxFit.fitWidth,
        ),
        Container(
          alignment: Alignment.bottomLeft,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 25),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: [0, 0.5],
              colors: [Colors.black, Colors.transparent],
            ),
          ),
          child: Text(
            item.title,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _renderDateItem(String date) {
    date = Utils.formatData(date);
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
