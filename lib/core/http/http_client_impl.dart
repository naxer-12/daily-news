import 'package:daily_news/core/di/InjectionContainer.dart';
import 'package:daily_news/core/http/HttpHelper.dart';
import 'package:daily_news/core/http/http_client.dart';
import 'package:daily_news/core/preference/PrefHelper.dart';
import 'package:daily_news/core/util/FlavorConfig.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


class RestClientImpl implements RestClient {
  RestClientImpl({@required this.dioClient});

  final Dio dioClient;

  @override
  RestHelper getClientWithHeaders(Map<String, dynamic> headers) {
    dioClient.options.headers = headers;
    dioClient.options.baseUrl = FlavorConfig.instance.baseUrl;
    return RestHelper(dioClient);
  }

  @override
  RestHelper getClientWithoutHeaders() {
    PrefHelper helper = sl();
    Map<String, String> headersMap = {
      'Content-Type': 'application/json',
      // 'Lang': helper.getLang(),
    };

    /*headersMap.putIfAbsent(
        'Token',
        () => helper.getAuthenticationToken().isEmpty
            ? null
            : helper.getAuthenticationToken());*/

    dioClient.options.headers = headersMap;
    dioClient.options.baseUrl = FlavorConfig.instance.baseUrl;
    return RestHelper(dioClient);
  }
}
