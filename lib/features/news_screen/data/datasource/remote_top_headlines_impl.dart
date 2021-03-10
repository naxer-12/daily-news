import 'package:daily_news/core/http/api_constants.dart';
import 'package:daily_news/features/news_screen/data/datasource/remote_top_headlines_data_source.dart';
import 'package:daily_news/features/news_screen/model/top_headlines_model.dart';

class TopHeadLinesSourceImpl extends TopHeadLinesRepoSource {
  @override
  Future<TopHeadLinesModel> callTopHeadLines(String location, String apiKey) =>
      restClient.getClient(NEWS_API).fetchHeadlines(location, apiKey);
}
