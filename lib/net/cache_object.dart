import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CacheObject {
  CacheObject(this.response)
      : timestamp = DateTime.now().millisecondsSinceEpoch;

  Response response;
  int timestamp; // 缓存创建时间

  @override
  bool operator ==(other) {
    return response.hashCode == other.hashCode;
  }

  @override
  // 将请求uri作为缓存的key
  int get hashCode => response.realUri.hashCode;
}


