import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class PrefHelper {
  Future<void> setUserLocation(Placemark placemark);

  Future<void> setUserPosition(Position position);

  String getCountry();

  String getPlace();

  double getLat();

  double getLon();

  Future<void> setUnitMetrics(bool metrics);

  bool getMetrics();
}
