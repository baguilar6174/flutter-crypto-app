import '../usecases/usecases.dart';

abstract class ExchangeRepository {
  Future<GetPricesResult> getPrices(String ids);
}
