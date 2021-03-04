import 'package:daily_news/core/di/DependencyInjector.dart';
import 'package:daily_news/core/http/http_client.dart';
import 'package:daily_news/core/http/http_client_impl.dart';
import 'package:daily_news/core/http/network_info.dart';
import 'package:daily_news/core/http/network_info_impl.dart';
import 'package:daily_news/features/news_screen/data/datasource/remote_data_source_impl.dart';
import 'package:daily_news/features/news_screen/data/domain/remote_top_headlines_data_repo_impl.dart';
import 'package:daily_news/features/news_screen/domain/repository/top_headlines_repo.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final sl = GetIt.instance;

// todo change as per requirements of mock data/prod data

Future<void> init() async {
  // Dependency Injector

  // sl.registerLazySingleton<AppDb>(() => AppDb());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => DataConnectionChecker());
  sl.registerLazySingleton<RestClient>(() => RestClientImpl(dioClient: sl()));
  Dio dio = Dio();
  sl.registerSingleton<Dio>(dio);
  sl.registerLazySingleton<TopHeadlinesRepo>(
    () => RemoteTopHeadLinesRepo(
      latestDataRepoSource: TopHeadLinesSourceImpl(),
    ),
  );

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
