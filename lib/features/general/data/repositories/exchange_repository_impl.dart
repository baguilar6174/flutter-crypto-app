import 'package:crypto_app/features/features.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSourceImpl remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<GetPricesResult> getPrices(List<String> ids) {
    return remoteDataSource.getPrices(ids);
  }
}
