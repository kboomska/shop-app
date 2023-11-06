import 'package:http/http.dart' as http;

abstract interface class IHttpClient {
  Future<http.StreamedResponse> send(http.BaseRequest request);
}

class HttpClientImpl implements IHttpClient {
  static final _client = http.Client();

  const HttpClientImpl();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _client.send(request);
}
