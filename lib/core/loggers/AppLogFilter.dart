import 'package:daily_news/core/util/FlavorConfig.dart';
import 'package:logger/logger.dart';

class AppLogFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) => !FlavorConfig.isDev();
}
