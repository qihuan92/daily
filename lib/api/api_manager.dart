import 'package:daily/model/base_model.dart';
import 'package:daily/model/before_resp.dart';
import 'package:daily/model/daily_detail.dart';
import 'package:daily/model/latest_resp.dart';
import 'package:dio/dio.dart';

class Api {
  static const String baseUrl = "https://news-at.zhihu.com";
}

/// 数据转换
typedef DataConverter<T> = T Function(dynamic json);

/// 网络请求管理
class ApiManger {
  static final ApiManger _instance = ApiManger._internal();
  Dio _dio;

  ApiManger._internal() {
    _dio = Dio(Options(
      baseUrl: Api.baseUrl,
      connectTimeout: 5000,
      receiveTimeout: 5000,
    ));
  }

  factory ApiManger() {
    return _instance;
  }

  /// 统一 GET 请求
  Future<BaseResp<T>> _get<T>(String url, {DataConverter converter}) async {
    BaseResp<T> resp = BaseResp();
    try {
      Response ogResp = await _dio.get(url);
      resp.data = converter(ogResp.data);
    } on DioError catch (e) {
      resp.code = RespCode.error;
      switch (e.type) {
        case DioErrorType.DEFAULT:
          resp.msg = '网络异常';
          break;
        case DioErrorType.CONNECT_TIMEOUT:
        case DioErrorType.RECEIVE_TIMEOUT:
          resp.msg = '请求超时';
          break;
        default:
          resp.msg = '网络错误(${e.message})';
      }
    }
    return resp;
  }

  /// 获取最近日报
  Future<BaseResp<LatestDailyResp>> latest() async {
    return await _get<LatestDailyResp>(
      '/api/4/news/latest',
      converter: (json) => LatestDailyResp.fromJson(json),
    );
  }

  /// 获取历史日报
  Future<BaseResp<BeforeResp>> before(String date) async {
    return await _get<BeforeResp>(
      "/api/4/news/before/$date",
      converter: (json) => BeforeResp.fromJson(json),
    );
  }

  /// 日报详情
  Future<BaseResp<DailyDetail>> detail(int id) async {
    return await _get<DailyDetail>(
      "/api/4/news/$id",
      converter: (json) => DailyDetail.fromJson(json),
    );
  }
}
