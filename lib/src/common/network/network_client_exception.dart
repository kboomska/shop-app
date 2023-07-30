enum NetworkClientExceptionType { network, other }

class NetworkClientException implements Exception {
  final NetworkClientExceptionType type;

  NetworkClientException(this.type);
}
