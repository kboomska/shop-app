import 'package:geocoding/geocoding.dart';

abstract interface class IGeocodingApiClient {
  Future<String?> getPlacemark({
    required String localeIdentifier,
    required (double, double) position,
  });
}

final class GeocodingApiClientImpl implements IGeocodingApiClient {
  const GeocodingApiClientImpl();

  @override
  Future<String?> getPlacemark({
    required String localeIdentifier,
    required (double, double) position,
  }) async {
    final (latitude, longitude) = position;

    final placemark = await placemarkFromCoordinates(
      latitude,
      longitude,
      localeIdentifier: localeIdentifier,
    );
    return placemark.first.locality;
  }
}
