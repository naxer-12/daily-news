import 'package:daily_news/features/weather_screen/presentation/bloc/weather_bloc.dart';
import 'package:daily_news/features/weather_screen/presentation/bloc/weather_event.dart';
import 'package:daily_news/features/weather_screen/presentation/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherBloc>(
      create: (context) => WeatherBloc()
        ..add(
          FetchWeatherDataEvent(),
        ),
      child: WeatherScreen(),
    );
  }
}
