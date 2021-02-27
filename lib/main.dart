import 'package:daily_news/core/routes/Routes.dart';

import 'package:flutter/material.dart';

import 'core/di/InjectionContainer.dart' as di;

void main() async {
  await di.init();
  runApp(DailyNewsApp());
}

class DailyNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: Routes.routes,


    );
  }
}
