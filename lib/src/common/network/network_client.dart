import 'dart:convert';
import 'dart:io';

import 'package:shop_app_bloc/src/common/network/network_client_exception.dart';
import 'package:shop_app_bloc/src/common/network/http_client.dart';

abstract interface class INetworkClient {
  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  );
}

class NetworkClientImpl implements INetworkClient {
  final IHttpClient _httpClient;

  const NetworkClientImpl({
    required IHttpClient httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<T> get<T>(
    String host,
    String path,
    T Function(dynamic json) parser,
  ) async {
    final url = Uri.parse('$host$path');

    try {
      final request = await _httpClient.getUrl(url);
      final response = await request.close();
      final dynamic json = (await response.jsonDecode());
      final result = parser(json);
      return result;
    } on SocketException {
      throw NetworkClientException(NetworkClientExceptionType.network);
    } catch (_) {
      throw NetworkClientException(NetworkClientExceptionType.other);
    }
  }
}

extension HttpClientResponseJsonDecode on HttpClientResponse {
  Future<dynamic> jsonDecode() async {
    return transform(utf8.decoder).toList().then((jsonStrings) {
      return jsonStrings.join();
    }).then((jsonString) => json.decode(jsonString));
  }
}
