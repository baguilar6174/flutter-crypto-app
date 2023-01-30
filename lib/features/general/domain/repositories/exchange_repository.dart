import '../usecases/usecases.dart';

abstract class ExchangeRepository {
  Future<GetPricesResult> getPrices(List<String> ids);
}
