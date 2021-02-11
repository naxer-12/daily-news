// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HttpHelper.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestHelper implements RestHelper {
  _RestHelper(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
  }

  final Dio _dio;

  String baseUrl;

  @override
  fetchLatestData() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'latest-news',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = ApiResponse.fromJson(_result.data);
    return value;
  }
}
