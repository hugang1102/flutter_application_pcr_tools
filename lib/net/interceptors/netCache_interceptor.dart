import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_application_pcr_tools/net/cache_object.dart';
import 'package:flutter_application_pcr_tools/utils/global_pref.dart';

/// 参数名	类型	解释
// refresh	bool	如果为true，则本次请求不使用缓存，但新的请求结果依然会被缓存
// noCache	bool	本次请求禁用缓存，请求结果也不会被缓存。
class NetCache extends Interceptor {
  // 为确保迭代器顺序和对象插入时间一致顺序一致，我们使用LinkedHashMap
  var cache = LinkedHashMap<String, CacheObject>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!GlobalPres.profile.cache!.enable) {
      return handler.next(options);
    }
    // refresh标记是否是"下拉刷新"
    bool refresh = options.extra["refresh"] == true;
    if (refresh) {
      if (options.extra["list"] == true) {
        //若是列表，则只要url中包含当前path的缓存全部删除（简单实现，并不精准）
        cache.removeWhere((key, value) => key.contains(options.path));
      } else {
        // 如果不是列表，则只删除uri相同的缓存
        delete(options.uri.toString());
      }
      return handler.next(options);
    }

    if (options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      var ob = cache[key];
      if (ob != null) {
        //若缓存未过期，则返回缓存内容
        var s = (DateTime.now().millisecondsSinceEpoch - ob.timestamp) / 1000 <
            GlobalPres.profile.cache!.maxAge;
        if (s) {
          return handler.resolve(ob.response);
        } else {
          //若已过期则删除缓存，继续向服务器请求
          cache.remove(key);
        }
      }
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 如果启用缓存，将返回结果保存到缓存
    if (GlobalPres.profile.cache!.enable) {
      _saveCache(response);
    }
    handler.next(response);
  }

  void delete(String key) {
    cache.remove(key);
  }

  _saveCache(Response object) {
    RequestOptions options = object.requestOptions;
    if(options.extra["noCache"] != true &&
        options.method.toLowerCase() == "get") {
    // 如果缓存数量超过最大数量限制，则先移除最早的一条记录
      if(cache.length == GlobalPres.profile.cache!.maxCount) {
        cache.remove(cache[cache.keys.first]);
      }
      String key = options.extra["cacheKey"] ?? options.uri.toString();
      cache[key] = CacheObject(object);
    }
  }
}
