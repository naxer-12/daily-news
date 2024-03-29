import 'package:daily_news/core/models/error/failure.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';
import 'package:daily_news/features/weather_screen/model/random_image.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';

abstract class WeatherStates {}

class InitialState extends WeatherStates {
  InitialState();
}

class LoadingWeatherState extends WeatherStates {}

class FetchedWeatherDataState extends WeatherStates {
  final WeatherModel weatherModel;
  final RandomImage randomImageModel;
  FetchedWeatherDataState({this.weatherModel, this.randomImageModel});
}

class ErrorApiState extends WeatherStates {
  final Failure failure;

  ErrorApiState(this.failure);
}
