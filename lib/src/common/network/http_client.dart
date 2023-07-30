import 'dart:io';

abstract interface class IHttpClient {
  Future<HttpClientRequest> getUrl(Uri url);
  Future<HttpClientRequest> postUrl(Uri url);
}

class HttpClientImpl implements IHttpClient {
  static final _client = HttpClient();

  const HttpClientImpl();

  @override
  Future<HttpClientRequest> getUrl(Uri url) => _client.getUrl(url);

  @override
  Future<HttpClientRequest> postUrl(Uri url) => _client.postUrl(url);
}
