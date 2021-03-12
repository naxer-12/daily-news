import 'package:daily_news/core/apirepo/base_api_repo.dart';
import 'package:daily_news/core/models/Success.dart';
import 'package:daily_news/core/models/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class WeatherDataRepo extends BaseApiRepo {
  WeatherDataRepo() : super();

  Future<Either<Failure, Success>> fetchWeatherData(
      double lat, double lon, String exclude, String appid, String units);

  Future<Either<Failure, Success>> fetchRandomPhoto(
      String query,String orientation,String clientId,String contentFilter);
}
