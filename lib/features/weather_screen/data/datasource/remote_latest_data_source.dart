import 'package:daily_news/core/apirepo/remote_repo.dart';
import 'package:daily_news/core/http/models/response_model.dart';

abstract class LatestDataRepoSource extends RemoteDataRepo {
  Future<ApiResponse> callLatestNewsApi();
}
