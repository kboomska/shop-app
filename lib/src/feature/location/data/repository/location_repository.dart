import 'package:flutter/material.dart';

import 'package:shop_app_bloc/src/feature/location/data/api/location_api_client.dart';

abstract interface class ILocationRepository {
  Future<String?> getAddress(Locale locale);
}

final class LocationRepositoryImpl implements ILocationRepository {
  final ILocationApiClient _locationApiClient;

  const LocationRepositoryImpl({
    required ILocationApiClient locationApiClient,
  }) : _locationApiClient = locationApiClient;

  @override
  Future<String?> getAddress(Locale locale) async {
    return _locationApiClient.getAddress(locale);
  }
}
