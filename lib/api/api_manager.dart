import 'package:daily/model/daily_detail.dart';
import 'package:daily/model/latest_resp.dart';
import 'package:dio/dio.dart';

class Api {
  static const String baseUrl = "http://news-at.zhihu.com";

  // 今日热闻
  static const String latest = "/api/4/news/latest";

  // 新闻详情
  static const String detail = "/api/4/news/";

  // 获取某个主题日报的列表
  static const String theme = "/api/4/theme/";

  // 获取theme列表
  static const String themeList = "/api/4/themes";
}

class ApiManger {
  static ApiManger instance;
  Dio _dio;

  ApiManger() {
    _dio = Dio(Options(
      baseUrl: Api.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));
  }

  static ApiManger getInstance() {
    if (instance == null) {
      instance = new ApiManger();
    }
    return instance;
  }

  Future<LatestDailyResp> latest() async {
    Response response = await _dio.get(Api.latest);
    return LatestDailyResp.fromJson(response.data);
  }

  Future<DailyDetail> detail(int id) async {
    Response response = await _dio.get(Api.detail + id.toString());
    return DailyDetail.fromJson(response.data);
  }
}
