import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../di/InjectionContainer.dart';

class CustomInterceptors extends InterceptorsWrapper {
  Logger logger = sl();

  @override
  Future onRequest(RequestOptions options) {
    logger.log(Level.verbose,
        "REQUEST[${options?.method}] => PATH: ${options?.path} => PARAM: ${options?.data}");
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    logger.log(Level.verbose,
        "RESPONSE[${response?.statusCode}] => PATH: ${response?.request?.path} => PARAM: ${response?.data}");
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    logger.log(Level.error,
        "ERROR[${err?.response?.statusCode}] => PATH: ${err?.request?.path}");
    return super.onError(err);
  }
}
