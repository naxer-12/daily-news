import 'package:daily_news/core/preference/prefs.dart';
import 'package:daily_news/core/routes/Routes.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/di/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Prefs.init();
  runApp(DailyNewsApp());
}

class DailyNewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splash,
      routes: Routes.routes,
    );
  }
}
