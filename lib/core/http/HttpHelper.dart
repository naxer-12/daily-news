import 'package:daily_news/core/http/api_constants.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'HttpHelper.g.dart';

//flutter pub run build_runner build.
//when with conflicts
//flutter pub run build_runner build --delete-conflicting-outputs
@RestApi(baseUrl: "")
abstract class RestHelper {
  factory RestHelper(Dio dio) = _RestHelper;

  @GET(TOP_HEADLINES)
  Future<TopHeadLinesModel> fetchHeadlines(
    @Query("country") String country,
    @Query("apiKey") String apiKey,
  );

  @GET('')
  Future<WeatherModel> fetchWeatherData(
    @Query("lat") double lat,
    @Query("lon") double lon,
    @Query("exclude") String exclude,
    @Query("appid") String appid,
  );
}
