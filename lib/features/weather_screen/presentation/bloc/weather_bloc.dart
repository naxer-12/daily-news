import 'package:daily_news/core/di/InjectionContainer.dart';
import 'package:daily_news/core/preference/PrefHelper.dart';
import 'package:daily_news/core/util/api_keys_constant.dart';
import 'package:daily_news/features/weather_screen/data/datasource/remote_weather_source.dart';
import 'package:daily_news/features/weather_screen/domain/repository/weather_data_repo.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_event.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final output = await weatherDataRepo.fetchWeatherData(
        helper.getLat(), helper.getLon(), exclude, WEATHER_API_KEY);

    yield* output.fold(
      (failure) async* {
        yield ErrorApiState(failure);
      },
      (responseModel) async* {
        yield FetchedWeatherDataState(responseModel.model);
      },
    );
  }
}
