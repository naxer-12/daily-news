import 'package:daily_news/core/di/injection_container.dart';
import 'package:daily_news/core/http/http_client.dart';

abstract class RemoteDataRepo {
  RestClient restClient = sl();
}
