import 'package:daily_news/features/splash/presentation/splash_screen.dart';
import 'package:daily_news/features/weather_screen/presentation/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Routes {
  //static variables

  static const String splash = 'splash';
  static const String weatherscreen = 'weatherscreen';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    weatherscreen: (BuildContext context) => WeatherScreen()
  };
}

class AppSlideRightRoute extends PageRouteBuilder {
  final Widget widget;

  AppSlideRightRoute({this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1.0, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
