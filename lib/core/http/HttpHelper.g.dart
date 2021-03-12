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
  Future<TopHeadLinesModel> fetchHeadlines(country, apiKey) async {
    ArgumentError.checkNotNull(country, 'country');
    ArgumentError.checkNotNull(apiKey, 'apiKey');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'country': country,
      r'apiKey': apiKey
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('top-headlines',
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
  Future<WeatherModel> fetchWeatherData(lat, lon, exclude, appid, units) async {
    ArgumentError.checkNotNull(lat, 'lat');
    ArgumentError.checkNotNull(lon, 'lon');
    ArgumentError.checkNotNull(exclude, 'exclude');
    ArgumentError.checkNotNull(appid, 'appid');
    ArgumentError.checkNotNull(units, 'units');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': lat,
      r'lon': lon,
      r'exclude': exclude,
      r'appid': appid,
      r'units': units
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('',
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

  @override
  Future<RandomImage> fetchRandomImage(
      query, orientation, clientId, contentFilter) async {
    ArgumentError.checkNotNull(query, 'query');
    ArgumentError.checkNotNull(orientation, 'orientation');
    ArgumentError.checkNotNull(clientId, 'clientId');
    ArgumentError.checkNotNull(contentFilter, 'contentFilter');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'orientation': orientation,
      r'client_id': clientId,
      r'content_filter': contentFilter
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('photos/random',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = RandomImage.fromJson(_result.data);
    return value;
  }
}
