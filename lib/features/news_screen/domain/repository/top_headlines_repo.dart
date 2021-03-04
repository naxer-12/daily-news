import 'package:daily_news/core/apirepo/BaseApiRepo.dart';
import 'package:daily_news/core/models/Success.dart';
import 'package:daily_news/core/models/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class TopHeadlinesRepo extends BaseApiRepo {
  TopHeadlinesRepo() : super();

  Future<Either<Failure, Success>> fetchLatestData(
      String location, String apiKey);
}
