import 'package:daily_news/core/di/InjectionContainer.dart';
import 'package:daily_news/core/http/http_client.dart';

abstract class RemoteDataRepo {
  RestClient restClient = sl();
}
