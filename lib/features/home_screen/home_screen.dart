import 'package:daily_news/features/news_screen/presentation/news_screen.dart';
import 'package:daily_news/features/weather_screen/presentation/weather_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageView(
      pageSnapping: true,
      children: [
        NewsScreen(),
        WeatherScreen(),
      ],
      onPageChanged: (value) {
        print("CHANGED VALUE :: $value");
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
