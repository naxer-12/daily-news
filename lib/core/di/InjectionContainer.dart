import 'package:daily_news/core/di/DependencyInjector.dart';
import 'package:daily_news/core/di/MockDIGetter.dart';
import 'package:daily_news/core/di/ProdDIGetter.dart';
import 'package:daily_news/core/loggers/AppLogFilter.dart';
import 'package:daily_news/core/loggers/AppLogPrinter.dart';
import 'package:daily_news/core/preference/PrefHelper.dart';
import 'package:daily_news/core/preference/PrefHelperImpl.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

// todo change as per requirements of mock data/prod data
final choice = Choice.PROD_DATA;

Future<void> init() async {
  // sl.registerLazySingleton<PrefHelper>(() => PrefHelperImpl());

  sl.registerLazySingleton<Logger>(
    () => Logger(
        filter: AppLogFilter(), printer: AppLogPrinter(prefHelper: sl())),
  );
  // Dependency Injector
  DIGetter getter =
      choice == Choice.MOCK_DATA ? MockDIGetter() : ProdDIGetter();
  // sl.registerLazySingleton<AppDb>(() => AppDb());

  Dio dio = Dio();
  dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90));
}
