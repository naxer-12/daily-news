import 'package:daily_news/core/apirepo/remote_repo.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';

abstract class TopHeadLinesRepoSource extends RemoteDataRepo {
  Future<TopHeadLinesModel> callTopHeadLines(String location, String apiKey);
}
