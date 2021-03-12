import 'dart:async';

import 'package:daily_news/core/di/injection_container.dart';
import 'package:daily_news/core/http/network_info.dart';
import 'package:daily_news/core/models/Success.dart';
import 'package:daily_news/core/models/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class BaseApiRepo {
  NetworkInfo networkInfo = sl();

  BaseApiRepo();

  Future<Either<Failure, Success>> baseApiMethod(
      Future<Either<Failure, Success>> Function() apiCall) async {
    bool isConnected = await networkInfo.isConnected;

    if (!isConnected) {
      return Left(
        Failure(
          message: "",
          status: "404"
        ),
      );
    }
    try {
      return await apiCall();
    } on DioError catch (e) {
      String statusMessage = "";
      int statusCode = 0;
      // if (e.response != null) {
      //   statusCode = e.response.statusCode;
      //   statusMessage = e.response.statusMessage;
      // }
      return Left(Failure(message: statusMessage));
    } on TimeoutException {
      return Left(Failure(message: ""));
    } catch (e) {
      return Left(Failure(message: "Unexpected error occurred"));
    } finally {}
  }
}
