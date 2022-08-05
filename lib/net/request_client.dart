import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_application_pcr_tools/net/api_exception.dart';
import 'package:flutter_application_pcr_tools/net/interceptors/error_interceptor.dart';
import 'package:flutter_application_pcr_tools/net/interceptors/netCache_interceptor.dart';
import 'package:flutter_application_pcr_tools/net/interceptors/request_interceptor.dart';
import 'package:flutter_application_pcr_tools/net/interceptors/response_interceptor.dart';
import 'package:flutter_application_pcr_tools/net/request_config.dart';
import 'package:flutter_application_pcr_tools/net/interceptors/token_interceptor.dart';
import 'package:flutter_application_pcr_tools/net/result_data.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

RequestClient requestClient = RequestClient();

class RequestClient {
  late Dio _dio;

  RequestClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: RequestConfig.baseUrl,
        connectTimeout: RequestConfig.connectTimeout,
      ),
    );
    _dio.interceptors.add(TokenInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
    _dio.interceptors.add(RequestInterceptor());
    _dio.interceptors.add(ResponseInterceptor());
    _dio.interceptors.add(GlobalPres.netCache);
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  Future<T?> request<T>(
    String url, {
    String method = "GET",
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool Function(ApiException)? onError,
  }) async {
    try {
      Options options = Options()
        ..method = method
        ..headers = headers;
      data = _convertRequestData(data);
      Response response = await _dio.request(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _handleResponse(response);
    } catch (e) {
      var exception = ApiException.from(e);
      if (onError?.call(exception) != true) {
        throw exception;
      }
    }
    return null;
  }

  Future<T?> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      queryParameters: queryParameters,
      headers: headers,
      onError: onError,
    );
  }

  Future<T?> post<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    data,
    Map<String, dynamic>? headers,
    bool showLoading = true,
    bool Function(ApiException)? onError,
  }) {
    return request(
      url,
      method: "POST",
      queryParameters: queryParameters,
      data: data,
      headers: headers,
      onError: onError,
    );
  }

  _convertRequestData(data) {
    if (data != null) {
      data = jsonDecode(jsonEncode(data));
    }
    return data;
  }

  ///请求响应内容处理
  T? _handleResponse<T>(Response response) {
    return response.data;
  }
}
