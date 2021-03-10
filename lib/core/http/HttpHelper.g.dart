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
  fetchHeadlines(country, apiKey) async {
    ArgumentError.checkNotNull(country, 'country');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'country': country,
      r'apiKey': apiKey
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request(
        'top-headlines',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TopHeadLinesModel.fromJson(_result.data);
    return value;
  }

  @override
  fetchWeatherData(lat, lon, exclude, appid) async {
    ArgumentError.checkNotNull(lat, 'lat');
    ArgumentError.checkNotNull(lon, 'lon');
    ArgumentError.checkNotNull(exclude, 'exclude');
    ArgumentError.checkNotNull(appid, 'appid');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lon': lon,
      r'exclude': exclude,
      r'appid': appid
    };
    final _data = <String, dynamic>{};
    final Response<Map<String, dynamic>> _result = await _dio.request('',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = WeatherModel.fromJson(_result.data);
    return value;
  }
}
