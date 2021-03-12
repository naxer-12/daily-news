import 'package:daily_news/features/weather_screen/presentation/weather_page.dart';
import 'package:daily_news/features/weather_screen/presentation/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:daily_news/features/news_screen/presentation/news_page.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  PageController _pageController = PageController(keepPage: true);

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return PageView(
      controller: _pageController,
      pageSnapping: true,
      children: [
        NewsPage(),
        WeatherPage(),
      ],
      onPageChanged: (value) {
        print("CHANGED VALUE :: $value");
      },
      scrollDirection: Axis.horizontal,
    );
  }
}
