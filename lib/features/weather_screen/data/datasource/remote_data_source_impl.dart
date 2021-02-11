import 'package:daily_news/core/http/models/response_model.dart';
import 'package:daily_news/features/weather_screen/data/datasource/remote_latest_data_source.dart';

class LatestDataSourceImpl extends LatestDataRepoSource {
  @override
  Future<ApiResponse> callLatestNewsApi() =>
      restClient.getClient().fetchLatestData();
}
