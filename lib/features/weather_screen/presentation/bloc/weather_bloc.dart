import 'package:daily_news/core/di/injection_container.dart';
import 'package:daily_news/core/preference/pref_helper.dart';
import 'package:daily_news/core/util/api_keys_constant.dart';
import 'package:daily_news/features/weather_screen/data/datasource/remote_weather_source.dart';
import 'package:daily_news/features/weather_screen/domain/repository/weather_data_repo.dart';
import 'package:daily_news/features/weather_screen/model/weather_model.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_event.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherStates> {
  WeatherBloc() : super(InitialState());
  WeatherDataRepo weatherDataRepo = sl();
  PrefHelper helper = sl();

  @override
  Stream<WeatherStates> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeatherDataEvent) {
      yield* fetchWeatherData();
    }
  }

  Stream<WeatherStates> fetchWeatherData() async* {
    yield LoadingWeatherState();

    String exclude = "hourly,minutely";
    String units;
    if (helper.getMetrics()) {
      units = "metric";
    } else {
      units = "imperial";
    }
    final output = await weatherDataRepo.fetchWeatherData(
        helper.getLat(), helper.getLon(), exclude, WEATHER_API_KEY, units);

    yield* output.fold((failure) async* {
      yield ErrorApiState(failure);
    }, (responseModel) async* {
      final output = await weatherDataRepo.fetchRandomPhoto(
          "${(responseModel.model as WeatherModel).current.weather[0].main}" +
              " " +
              "${helper.getPlace()}",
          "portrait",
          UNSPLASH_API_KEY,
          "high");

      yield* output.fold((failure) async* {
        yield FetchedWeatherDataState(weatherModel: responseModel.model);
      }, (randomImageModel) async* {
        yield FetchedWeatherDataState(
            randomImageModel: randomImageModel.model,
            weatherModel: responseModel.model);
      });
    });
  }
}
