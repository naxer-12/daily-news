import 'package:daily_news/core/di/InjectionContainer.dart';
import 'package:daily_news/features/splash/presentation/splash_screen.dart';
import 'package:daily_news/features/weather_screen/presentation/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';

Logger logger = sl();

// use this method to navigate screen with route name
navigateTo(BuildContext context, String routeName,
    {bool backClear = false, Object arguments}) async {
  try {
    var string = "";
    if (routeName != null && routeName.isNotEmpty)
      string += "routeName " + routeName;
    string += " backClear " + backClear.toString();
    if (arguments != null) string += " arguments " + arguments.toString();
    if (string.isNotEmpty) logger.v("navigateTo " + string);
    if (backClear)
      await Navigator.pushNamedAndRemoveUntil(
          context, routeName, (route) => false,
          arguments: arguments);
    else
      await Navigator.pushNamed(context, routeName, arguments: arguments);
  } catch (e) {
    logger.e("navigateTo ex " + e.toString());
  }
}

// use this method to pop screen as well as set result for that screen
goBack(BuildContext context, {String route, dynamic result}) {
  try {
    var string = "";
    if (route != null && route.isNotEmpty)
      string += "route= " + route.toString();
    if (result != null) string += " result= " + result.toString();
    if (string.isNotEmpty) logger.v("goBack " + string);
    Navigator.pop(context, result);
  } catch (e) {
    logger.e("goBack ex " + e.toString());
  }
}

// use this method to navigate screen with clear back screens adding routename as well as route widget
navigateWithRemoveUntil(BuildContext context, String routeName, Widget route) {
  try {
    var string = "";
    if (routeName != null && routeName.isNotEmpty)
      string += "routeName= " + routeName.toString();
    if (route != null) string += " route= " + route.toString();
    if (string.isNotEmpty) logger.v("navigateWithRemoveUntil " + string);
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => route),
        ModalRoute.withName(routeName));
  } catch (e) {
    logger.e("navigateWithRemoveUntil ex " + e.toString());
  }
}

// use this method to navigate screen with push any widget
Future<dynamic> navigatePush(BuildContext context, Widget route,
    {bool fullscreenDialog}) async {
  try {
    var string = "";
    if (route != null) string += "route= " + route.toString();
    if (fullscreenDialog != null)
      string += " fullscreenDialog= " + fullscreenDialog.toString();
    if (string.isNotEmpty) logger.v("navigatePush " + string);
    return await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => route,
          fullscreenDialog:
              ((fullscreenDialog == null) ? false : fullscreenDialog)),
    );
  } catch (e) {
    logger.e("navigatePush ex" + e.toString());
  }
}

// use this method to navigate screen with push and custom navigator
Future<dynamic> pushWithNavigator(
    NavigatorState navigatorState, Widget route) async {
  try {
    var string = "";
    if (route != null) string += "route= " + route.toString();
    if (navigatorState != null)
      string += "navigatorState= " + navigatorState.toString();
    if (string.isNotEmpty) logger.v("pushWithNavigator " + string);
    return await navigatorState
        .push(MaterialPageRoute(builder: (context) => route));
  } catch (e) {
    logger.e("pushWithNavigator ex" + e.toString());
  }
}

// use this method to navigate screen with push and custom navigator
Future<dynamic> popUntilWithNavigator(
    NavigatorState navigatorState, Function(bool) onResult) async {
  navigatorState.popUntil((route) {
    var name = route?.settings?.name ?? "";
    bool result = name == "/";
    logger.v("popUntilWithNavigator " + name);
    onResult(result);
    return result;
  });
}

// use this method to navigate screen with root navigator and passing route
Future<dynamic> navigatePushRootNavigator(
    BuildContext context, bool rootNavigator, Route route) async {
  try {
    var string = "";
    if (rootNavigator != null)
      string += "rootNavigator= " + (rootNavigator ?? "").toString();
    if (route != null) string += " route= " + (route ?? "").toString();
    if (string.isNotEmpty) logger.v("navigatePushRootNavigator " + string);
    return await Navigator.of(context, rootNavigator: rootNavigator)
        .push(route);
  } catch (e) {
    logger.e("navigatePushRootNavigator ex" + e.toString());
  }
}

// use this method to navigate screen with replacement passing widget
navigatePushReplacement(BuildContext context, Widget route) {
  try {
    if (route != null) logger.v("navigatePushReplacement " + route.toString());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => route,
      ),
    );
  } catch (e) {
    logger.e("navigatePushReplacement ex " + e.toString());
  }
}

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
