import 'package:daily_news/core/preference/PrefHelper.dart';
import 'package:daily_news/core/util/FlavorConfig.dart';
import 'package:logger/logger.dart';

class AppLogPrinter extends LogPrinter {
  final PrefHelper prefHelper;

  AppLogPrinter({this.prefHelper});

  @override
  List<String> log(LogEvent event) {
    throw UnimplementedError();
  }
}
