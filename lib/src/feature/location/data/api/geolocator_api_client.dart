import 'package:geolocator/geolocator.dart';

import 'package:shop_app_bloc/src/feature/location/data/api/geolocator_api_client_exception.dart';

abstract interface class IGeolocatorApiClient {
  Future<(double, double)> determinePosition();
}

final class GeolocatorApiClientImpl implements IGeolocatorApiClient {
  const GeolocatorApiClientImpl();

  @override
  Future<(double, double)> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw LocationApiClientExceptionType.services;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw LocationApiClientExceptionType.permission;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw LocationApiClientExceptionType.permission;
    }

    return _getCurrentLocation();
  }

  Future<(double, double)> _getCurrentLocation() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
    } catch (_) {
      throw LocationApiClientExceptionType.other;
    }
    return (position.latitude, position.longitude);
  }
}
