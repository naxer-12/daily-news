import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'HttpHelper.g.dart';

//flutter pub run build_runner build.
//when with conflicts
//flutter pub run build_runner build --delete-conflicting-outputs.
@RestApi(baseUrl: "")
abstract class RestHelper {
  factory RestHelper(Dio dio) = _RestHelper;

/*@GET(FetchHomeData)
  Future<ApiResponse> fetchHomeData();*/

}
