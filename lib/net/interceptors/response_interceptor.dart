import 'package:dio/dio.dart';
import 'package:flutter_application_pcr_tools/net/net_code.dart';
import 'package:flutter_application_pcr_tools/net/result_data.dart';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    RequestOptions options = response.requestOptions;
    var value;
    try {
      var header = response.headers[Headers.contentTypeHeader];
      if (header != null && header.toString().contains("text")) {
        value = ResultData(response.data, true, NetCode.SUCCESS);
      } else if (response.statusCode! >= 200 && response.statusCode! < 300) {
        value = ResultData(response.data, true, NetCode.SUCCESS,
            headers: response.headers);
      }
    } catch (e) {
      value = ResultData(response.data, false, response.statusCode,
          headers: response.headers);
    }
    response.data = value;
    return handler.next(response);
  }
}
