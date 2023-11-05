sealed class NetworkException extends _$NetworkExceptionBase {
  const NetworkException({
    super.message,
    super.statusCode,
  });
}

final class RestClientException extends NetworkException {
  const RestClientException({
    super.message,
    super.statusCode,
  });

  @override
  String toString() {
    final buffer = StringBuffer()..write('RestClientException(');
    if (message != null) buffer.write('message: $message');
    if (statusCode != null) buffer.write(', statusCode: $statusCode');
    buffer.write(')');
    return buffer.toString();
  }
}

final class InternalServerException extends NetworkException {
  const InternalServerException({
    super.message,
    super.statusCode,
  });

  @override
  String toString() {
    final buffer = StringBuffer()..write('InternalServerErrorException(');
    if (message != null) buffer.write('message: $message');
    if (statusCode != null) buffer.write(', statusCode: $statusCode');
    buffer.write(')');
    return buffer.toString();
  }
}

abstract base class _$NetworkExceptionBase implements Exception {
  const _$NetworkExceptionBase({
    this.message,
    this.statusCode,
  });

  final String? message;
  final int? statusCode;
}
