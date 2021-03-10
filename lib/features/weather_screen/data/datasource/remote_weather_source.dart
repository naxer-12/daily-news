import 'package:daily_news/core/apirepo/remote_repo.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';

abstract class WeatherDataRepoSource extends RemoteDataRepo {
  Future<WeatherModel> callWeatherDataApi(
      double lat, double lon, String exclude, String appid);
}
