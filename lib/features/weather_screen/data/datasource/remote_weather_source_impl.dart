import 'package:daily_news/core/http/api_constants.dart';
import 'package:daily_news/features/weather_screen/data/datasource/remote_weather_source.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';

class WeatherDataSourceImpl extends WeatherDataRepoSource {
  @override
  Future<WeatherModel> callWeatherDataApi(
          double lat, double lon, String exclude, String appid) =>
      restClient.getClient(WEATHER_API).fetchWeatherData(lat, lon, exclude, appid);
}
