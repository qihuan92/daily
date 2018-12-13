import 'package:daily/api/api_manager.dart';
import 'package:daily/model/daily_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class DailyDetailPage extends StatefulWidget {
  final int id;

  DailyDetailPage({this.id});

  @override
  State<StatefulWidget> createState() {
    return _DailyDetailState();
  }
}

class _DailyDetailState extends State<DailyDetailPage> {
  DailyDetail _dailyDetail;

  @override
  void initState() {
    super.initState();
    getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return renderContent(context);
  }

  Widget renderContent(BuildContext context) {
    if (_dailyDetail == null) {
      return Scaffold(
        appBar: AppBar(),
        body: _renderLoadingView(),
      );
    }

    return WebviewScaffold(
      appBar: AppBar(title: Text(_dailyDetail.title)),
      url: _dailyDetail.shareUrl,
      withJavascript: true,
      clearCache: true,
      initialChild: _renderLoadingView(),
    );
  }

  Widget _renderLoadingView() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void getDetail(int id) async {
    DailyDetail dailyDetail = await ApiManger.getInstance().detail(id);
    setState(() {
      _dailyDetail = dailyDetail;
    });
  }
}
