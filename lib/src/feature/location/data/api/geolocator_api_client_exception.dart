enum LocationApiClientExceptionType { permission, services, other }

class LocationApiClientException implements Exception {
  final LocationApiClientExceptionType type;

  LocationApiClientException(this.type);
}
