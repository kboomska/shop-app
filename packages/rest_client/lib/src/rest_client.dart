import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import 'package:rest_client/src/exception/network_exception.dart';
import 'package:rest_client/src/http_client.dart';

abstract interface class IRestClient {
  Future<Map<String, Object?>> get(
    String host,
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  });
}

class RestClientImpl implements IRestClient {
  RestClientImpl({
    required IHttpClient client,
  }) : _client = client;

  final IHttpClient _client;

  @override
  Future<Map<String, Object?>> get(
    String host,
    String path, {
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) =>
      _send(
        host,
        path,
        method: 'GET',
        headers: headers,
        queryParams: queryParams,
      );

  Future<Map<String, Object?>> _send(
    String host,
    String path, {
    required String method,
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParams,
  }) async {
    try {
      final request = buildRequest(
        host: host,
        path: path,
        method: method,
        queryParams: queryParams,
        headers: headers,
        body: body,
      );
      final response = await _client.send(request).then(
            http.Response.fromStream,
          );

      if (response.statusCode > 199 && response.statusCode < 300) {
        return decodeResponse(response);
      } else if (response.statusCode > 499) {
        throw InternalServerException(
          statusCode: response.statusCode,
          message: response.body,
        );
      } else if (response.statusCode > 399) {
        // final decoded = jsonDecode(response.body) as Map<String, Object?>?;
        throw RestClientException(
          statusCode: response.statusCode,
          // Set there your field which server returns in case of error
          // message: decoded?['message'] as String?,
          message: response.body,
        );
      }
      throw UnsupportedError('Unsupported statusCode: ${response.statusCode}');
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        RestClientException(message: 'Unsupported error: $e'),
        stackTrace,
      );
    }
  }

  static List<int> encodeBody(
    Map<String, Object?> body,
  ) {
    try {
      return utf8.encode(json.encode(body));
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        RestClientException(message: 'Error occured during encoding body $e'),
        stackTrace,
      );
    }
  }

  static Map<String, Object?> decodeResponse(http.Response response) {
    final contentType =
        response.headers['content-type'] ?? response.headers['Content-Type'];
    if (contentType?.contains('application/json') ?? false) {
      final body = response.body;
      try {
        final json = jsonDecode(body) as Map<String, Object?>;
        // Set there your field which server returns in case of error
        if (json['message'] != null) {
          throw RestClientException(message: json['message'].toString());
        }
        // Set there your field which server returns in case of success
        return json;
      } on Object catch (error, stackTrace) {
        if (error is NetworkException) rethrow;

        Error.throwWithStackTrace(
          InternalServerException(
            message: 'Server returned invalid json: $error',
          ),
          StackTrace.fromString(
            '$stackTrace\n'
            'Body: "${body.length > 100 ? '${body.substring(0, 100)}...' : body}"',
          ),
        );
      }
    } else {
      Error.throwWithStackTrace(
        InternalServerException(
          message: 'Server returned invalid content type: $contentType',
          statusCode: response.statusCode,
        ),
        StackTrace.fromString(
          '${StackTrace.current}\n'
          'Headers: "${jsonEncode(response.headers)}"',
        ),
      );
    }
  }

  static Uri buildUri({
    required String host,
    required String path,
    Map<String, Object?>? queryParams,
  }) {
    final baseUri = Uri.parse(host);
    final uri = Uri.tryParse(path);
    if (uri == null) return baseUri;

    final queryParameters = <String, Object?>{
      ...baseUri.queryParameters,
      ...uri.queryParameters,
      ...?queryParams,
    };

    return baseUri.replace(
      path: p.normalize(p.join(baseUri.path, uri.path)),
      queryParameters: queryParameters.isEmpty ? null : queryParameters,
    );
  }

  static http.Request buildRequest({
    required String host,
    required String path,
    required String method,
    Map<String, Object?>? queryParams,
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
  }) {
    final uri = buildUri(
      host: host,
      path: path,
      queryParams: queryParams,
    );
    final request = http.Request(method, uri);
    if (body != null) request.bodyBytes = encodeBody(body);
    request.headers.addAll({
      if (body != null) ...{
        'Content-Type': 'application/json;charset=utf-8',
        'Content-Length': request.bodyBytes.length.toString(),
      },
      'Connection': 'Keep-Alive',
      // the same as `"Cache-Control": "no-cache"`, but deprecated
      // however, to support older servers that tie to HTTP/1.0 this should
      // be included. According to RFC this header can be included and used
      // by the server even if it is HTTP/1.1+
      'Pragma': 'no-cache',
      'Accept': 'application/json',
      ...?headers?.map((key, value) => MapEntry(key, value.toString())),
    });
    return request;
  }
}
