import 'package:crypto_app/core/failures/failures.dart';
import 'package:crypto_app/features/general/domain/entities/entities.dart';

abstract class GetPricesResult {}

class GetPricesSuccess extends GetPricesResult {
  GetPricesSuccess(this.cryptos);

  final List<Crypto> cryptos;
}

class GetPricesFailure extends GetPricesResult {
  GetPricesFailure(this.failure);

  final HttpRequestFailure failure;
}
