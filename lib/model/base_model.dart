class BaseResp<T> {
  int code;
  String msg;
  T data;

  BaseResp({this.code = RespCode.success, this.msg = '成功', this.data});

  bool success() => code == RespCode.success;
}

class RespCode {
  static const int success = 0;
  static const int error = 1;
}
