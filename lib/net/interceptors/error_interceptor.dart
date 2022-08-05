import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ErrorInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //没有网络
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return handler.reject(
        DioError(
          requestOptions: options,
          type: DioErrorType.other,
          response: Response(requestOptions: options),
        ),
      );
    }
    super.onRequest(options, handler);
  }
}
