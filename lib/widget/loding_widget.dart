import 'package:flutter/material.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingFooterWidget extends StatelessWidget {
  final int mode;

  const LoadingFooterWidget(this.mode);

  @override
  Widget build(BuildContext context) {
    return ClassicIndicator(
      mode: mode,
      idleText: '上拉加载',
      idleIcon: Container(),
      refreshingText: '加载中...',
      refreshingIcon: SpinKitFadingFour(
        color: Theme.of(context).primaryColor,
        size: 18,
      ),
      failedText: '加载失败',
      failedIcon: Icon(Icons.error, color: Colors.black38),
      completeText: '加载完成',
      completeIcon: Icon(Icons.sentiment_satisfied,
          color: Theme.of(context).primaryColor),
      noDataText: '没有更多数据',
      noMoreIcon:
          Icon(Icons.sentiment_neutral, color: Theme.of(context).primaryColor),
    );
  }
}

class LoadingHeaderWidget extends StatelessWidget {
  final int mode;

  const LoadingHeaderWidget(this.mode);

  @override
  Widget build(BuildContext context) {
    return ClassicIndicator(
      mode: mode,
      idleText: '下拉可刷新...',
      idleIcon: Icon(
        Icons.arrow_downward,
        size: 18,
        color: Theme.of(context).primaryColor,
      ),
      releaseText: '释放可刷新...',
      releaseIcon: Icon(
        Icons.arrow_downward,
        size: 18,
        color: Theme.of(context).primaryColorDark,
      ),
      refreshingText: '加载中...',
      refreshingIcon: SpinKitFadingFour(
        color: Theme.of(context).primaryColor,
        size: 18,
      ),
      failedText: '加载失败',
      failedIcon: Icon(Icons.error, color: Colors.black38),
      completeText: '加载完成',
      completeIcon: Icon(
        Icons.sentiment_satisfied,
        color: Theme.of(context).primaryColor,
      ),
      noDataText: '没有更多数据',
      noMoreIcon: Container(),
    );
  }
}
