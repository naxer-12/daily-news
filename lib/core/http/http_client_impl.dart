import 'package:daily_news/core/http/HttpHelper.dart';
import 'package:daily_news/core/http/http_client.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestClientImpl implements RestClient {
  RestClientImpl({@required this.dioClient});

  final Dio dioClient;

  @override
  RestHelper getClient() {
    // PrefHelper helper = sl();
    Map<String, String> headersMap = {
      'Content-Type': 'application/json',
    };

    dioClient.options.headers = headersMap;
    dioClient.options.baseUrl = "https://api.currentsapi.services/v1/";
    dioClient.options.queryParameters = {"apiKey": "", "language": "en"};

    return RestHelper(dioClient);
  }
}
