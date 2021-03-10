import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

abstract class PrefHelper {
  void setUserLocation(Placemark placemark);

  void setUserPosition(Position position);

  String getCountry();

  String getPlace();

  double getLat();

  double getLon();
}
