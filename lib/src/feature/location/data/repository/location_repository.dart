import 'package:shop_app_bloc/src/feature/location/data/api/geolocator_api_client.dart';
import 'package:shop_app_bloc/src/feature/location/data/api/geocoding_api_client.dart';

abstract interface class ILocationRepository {
  Future<String?> getAddress(String localeTag);
}

final class LocationRepositoryImpl implements ILocationRepository {
  final IGeolocatorApiClient _geolocatorApiClient;
  final IGeocodingApiClient _geocodingApiClient;

  const LocationRepositoryImpl({
    required IGeolocatorApiClient geolocatorApiClient,
    required IGeocodingApiClient geocodingApiClient,
  })  : _geolocatorApiClient = geolocatorApiClient,
        _geocodingApiClient = geocodingApiClient;

  @override
  Future<String?> getAddress(String localeTag) async {
    final position = await _geolocatorApiClient.determinePosition();

    return _geocodingApiClient.getPlacemark(
      localeIdentifier: localeTag,
      position: position,
    );
  }
}
