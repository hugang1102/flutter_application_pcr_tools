import 'package:dio/dio.dart';
import 'package:flutter_application_pcr_tools/config/config.dart';
import 'package:flutter_application_pcr_tools/utils/local_storage.dart';

class TokenInterceptor extends InterceptorsWrapper {
  String? _token;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    // 授权码
    if(_token == null) {
      var authorizationCode = await getAuthorization();
      if (authorizationCode != null) {
        _token = authorizationCode;
        // 获取 token
      }
    }
    if(_token != null) {
      options.headers["Authorization"] = _token;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      var responseJson = response.data;
      if(response.statusCode == 201 && responseJson["token"]){
        _token = 'token'+responseJson["token"];
        await LocalStorage.save(Config.TOKEN_KEY, _token);
      }
    }catch(e){
      print(e);
    }
    super.onResponse(response, handler);
  }

  ///清除授权
  clearAuthorization() {
    this._token = null;
    LocalStorage.remove(Config.TOKEN_KEY);
  }

  ///获取授权token
  getAuthorization() async {
    String? token = await LocalStorage.get(Config.TOKEN_KEY);
    if (token == null) {
      String? basic = await LocalStorage.get(Config.USER_BASIC_CODE);
      if (basic == null) {
        //提示输入账号密码
      } else {
        //通过 basic 去获取token，获取到设置，返回token
        return "Basic $basic";
      }
    } else {
      this._token = token;
      return token;
    }
  }
}