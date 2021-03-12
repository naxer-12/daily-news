import 'package:daily_news/core/preference/pref_constants.dart';
import 'package:daily_news/core/preference/pref_helper.dart';
import 'package:daily_news/core/preference/prefs.dart';
import 'package:geocoding_platform_interface/src/models/placemark.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';

class PrefHelperImpl implements PrefHelper {
  @override
  Future<void> setUserLocation(Placemark placemark) async {
    await setUserCountry(placemark.country);
    await setUserPlace(placemark.administrativeArea);
  }

  Future<void> setUserCountry(String country) async {
    await Prefs.setString(KEY_COUNTRY, country);
  }

  Future<void> setUserPlace(String place) async {
    await Prefs.setString(KEY_PLACE, place);
  }

  @override
  String getCountry() => Prefs.getString(KEY_COUNTRY);

  @override
  String getPlace() => Prefs.getString(KEY_PLACE);

  @override
  Future<void> setUserPosition(Position position) async {
    await setLat(position.latitude);
    await setLon(position.longitude);
  }

  Future<void> setLon(double longitude) async {
    await Prefs.setDouble(KEY_LON, longitude);
  }

  Future<void> setLat(double latitude) async {
    await Prefs.setDouble(KEY_LAT, latitude);
  }

  @override
  double getLat() => Prefs.getDouble(KEY_LAT);

  @override
  double getLon() => Prefs.getDouble(KEY_LON);

  @override
  bool getMetrics() => Prefs.getBool(KEY_UNIT_METRICS,true);

  @override
  Future<void> setUnitMetrics(bool metrics) async {
    await Prefs.setBool(KEY_UNIT_METRICS, metrics);
  }
}
