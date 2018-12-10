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
  String title = '';
  String shareUrl = '';

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
    if (shareUrl.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(title)),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return WebviewScaffold(
      appBar: AppBar(title: Text(title)),
      url: shareUrl,
      withJavascript: true,
      clearCache: true,
    );
  }

  void getDetail(int id) async {
    DailyDetail dailyDetail = await ApiManger.getInstance().detail(id);
    setState(() {
      title = dailyDetail.title;
      shareUrl = dailyDetail.shareUrl;
    });
  }
}
