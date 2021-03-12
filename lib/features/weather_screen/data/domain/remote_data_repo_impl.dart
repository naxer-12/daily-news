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
          double lat, double lon, String exclude, String appid, String units) =>
      baseApiMethod(() => _fetchWeather(lat, lon, exclude, appid, units));

  Future<Either<Failure, Success>> _fetchWeather(double lat, double lon,
      String exclude, String appid, String units) async {
    var response = await weatherDataRepoSource.callWeatherDataApi(
        lat, lon, exclude, appid, units);
    if (response == null) {
      return Left(
        Failure(message: ""),
      );
    } else {
      Success dataModel = Success(response);
      return Right(dataModel);
    }
  }

  @override
  Future<Either<Failure, Success>> fetchRandomPhoto(String query,
          String orientation, String clientId, String contentFilter) =>
      baseApiMethod(
          () => _fetchRandomImage(query, orientation, clientId, contentFilter));

  Future<Either<Failure, Success>> _fetchRandomImage(String query,
      String orientation, String clientId, String contentFilter) async {
    var response = await weatherDataRepoSource.callRandomPhotoApi(
        query, orientation, clientId, contentFilter);
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
