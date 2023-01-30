import 'package:crypto_app/core/core.dart';
import 'package:crypto_app/features/features.dart';

abstract class ExchangeRepository {
  Future<Either<HttpRequestFailure, List<Crypto>>> getPrices(List<String> ids);
}
