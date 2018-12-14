import 'package:daily/api/api_manager.dart';
import 'package:daily/model/base_model.dart';
import 'package:daily/model/daily_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    if (_dailyDetail == null) {
      return _renderLoadingView();
    }
    return _renderContent(context);
  }

  Widget _renderLoadingView() {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _renderContent(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(title: Text(_dailyDetail.title)),
      url: _dailyDetail.shareUrl.replaceFirst('http', 'https'),
      withJavascript: true,
      clearCache: true,
      initialChild: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  void getDetail(int id) async {
    BaseResp<DailyDetail> resp = await ApiManger.getInstance().detail(id);
    setState(() {
      if (!resp.success()) {
        Fluttertoast.showToast(msg: resp.msg);
        return;
      }
      _dailyDetail = resp.data;
    });
  }
}
