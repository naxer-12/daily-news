import 'HttpHelper.dart';

abstract class RestClient {
  RestHelper getClient(String url);
}
