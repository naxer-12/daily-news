import 'package:daily_news/core/models/Success.dart';
import 'package:daily_news/core/models/error/failure.dart';
import 'package:daily_news/features/news_screen/data/datasource/remote_top_headlines_data_source.dart';
import 'package:daily_news/features/news_screen/domain/repository/top_headlines_repo.dart';
import 'package:dartz/dartz.dart';

class RemoteTopHeadLinesRepo extends TopHeadlinesRepo {
  final TopHeadLinesRepoSource latestDataRepoSource;

  RemoteTopHeadLinesRepo({this.latestDataRepoSource});

  @override
  Future<Either<Failure, Success>> fetchLatestData(
          String location, String apiKey) =>
      baseApiMethod(() => _fetchLatestNews(location, apiKey));

  Future<Either<Failure, Success>> _fetchLatestNews(
      String location, String apiKey) async {
    var response =
        await latestDataRepoSource.callTopHeadLines(location, apiKey);
    if (response == null) {
      return Left(
        Failure(message: ""),
      );
    } else {
      Success dataModel = Success(response);
      return Right(dataModel);
    }
  }
}
