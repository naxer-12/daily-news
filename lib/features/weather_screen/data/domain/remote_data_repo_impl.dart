import 'package:daily_news/core/models/Success.dart';
import 'package:daily_news/core/models/error/failure.dart';
import 'package:daily_news/features/weather_screen/data/datasource/remote_weather_source.dart';
import 'package:daily_news/features/weather_screen/domain/repository/weather_data_repo.dart';
import 'package:dartz/dartz.dart';

class RemoteWeatherData extends WeatherDataRepo {
  final WeatherDataRepoSource weatherDataRepoSource;

  RemoteWeatherData({this.weatherDataRepoSource});

  @override
  Future<Either<Failure, Success>> fetchWeatherData(
          double lat, double lon, String exclude, String appid) =>
      baseApiMethod(() => _fetchWeather(lat, lon, exclude, appid));

  Future<Either<Failure, Success>> _fetchWeather(
      double lat, double lon, String exclude, String appid) async {
    var response = await weatherDataRepoSource.callWeatherDataApi(
        lat, lon, exclude, appid);
    if (response == null) {
      return Left(
        Failure(message: ""),
      );
    } else {
      Success dataModel = Success(response);
      return Right(dataModel);
    }
  }
}
