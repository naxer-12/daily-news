import 'package:daily_news/core/models/Success.dart';
import 'package:daily_news/core/models/error/failure.dart';
import 'package:daily_news/features/weather_screen/data/datasource/remote_latest_data_source.dart';
import 'package:daily_news/features/weather_screen/domain/repository/latest_data_repo.dart';
import 'package:dartz/dartz.dart';

class RemoteContentPageDataRepoImpl extends LatestDataRepo {
  final LatestDataRepoSource latestDataRepoSource;

  RemoteContentPageDataRepoImpl({this.latestDataRepoSource});

  @override
  Future<Either<Failure, Success>> fetchLatestData() =>
      baseApiMethod(() => _fetchLatestNews());

  Future<Either<Failure, Success>> _fetchLatestNews() async {
    var response = await latestDataRepoSource.callLatestNewsApi();
    if (response == null ) {
      return Left(
        Failure(message: ""),
      );
    } else {
      // NewsData latestData = NewsData();
      // print(response.news[0]);
      // latestData.news.addAll(response.news);
      print("LATEST DATA RECEIVED");
      Success dataModel = Success(response);
      return Right(dataModel);
    }
  }
}
