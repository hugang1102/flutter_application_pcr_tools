import 'package:dio/dio.dart';

class ApiException implements Exception {
  static const unknownException = "未知错误";
  final String? message;
  final int? code;
  String? stackInfo;

  ApiException([this.code, this.message]);

  factory ApiException.fromDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.cancel:
        return BadRequestException(-1, "请求取消");
      case DioErrorType.connectTimeout:
        return BadRequestException(-1, "连接超时");
      case DioErrorType.sendTimeout:
        return BadRequestException(-1, "请求超时");
      case DioErrorType.receiveTimeout:
        return BadRequestException(-1, "响应超时");
      case DioErrorType.response:
        return ApiException(-1, unknownException);
      default:
        return ApiException(-1, error.message);
    }
  }

  factory ApiException.from(dynamic exception) {
    if (exception is DioError) {
      return ApiException.fromDioError(exception);
    }
    if (exception is ApiException) {
      return exception;
    } else {
      var apiException = ApiException(-1, unknownException);
      apiException.stackInfo = exception?.toString();
      return apiException;
    }
  }
}

/// 请求错误
class BadRequestException extends ApiException {
  BadRequestException([int? code, String? message]) : super(code, message);
}

/// 未认证异常
class UnauthorisedException extends ApiException {
  UnauthorisedException([int code = -1, String message = ''])
      : super(code, message);
}
