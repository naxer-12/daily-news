import 'HttpHelper.dart';

abstract class RestClient {
  RestHelper getClientWithHeaders(Map<String, String> headers);

  RestHelper getClientWithoutHeaders();
}
