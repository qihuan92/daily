import 'package:dio/dio.dart';

class ApiManger {
  static final String baseUrl = "http://news-at.zhihu.com";

  // 今日热闻
  static final String getLatest = "/api/4/news/latest";

  // 新闻详情
  static final String getDetailContent = "/api/4/story/";

  // 获取某个主题日报的列表
  static final String getTheme = "/api/4/theme/";

  // 获取theme列表
  static final String themes = "/api/4/themes";

  static final String GET = 'GET';
  static final String POST = 'POST';

  static ApiManger instance;
  Dio _dio;

  ApiManger() {
    _dio = Dio(Options(
      baseUrl: baseUrl,
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

  void latest() async {
    await _dio.get(getLatest);
  }
}
