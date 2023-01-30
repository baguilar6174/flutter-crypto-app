import 'package:freezed_annotation/freezed_annotation.dart';

part 'http_failure.freezed.dart';

@freezed
class HttpRequestFailure with _$HttpRequestFailure {
  factory HttpRequestFailure.network() = Network;
  factory HttpRequestFailure.notFound() = NotFound;
  factory HttpRequestFailure.server() = Server;
  factory HttpRequestFailure.unauthorized() = Unauthorized;
  factory HttpRequestFailure.badRequest() = BadRequest;
  factory HttpRequestFailure.local() = Local;
}
