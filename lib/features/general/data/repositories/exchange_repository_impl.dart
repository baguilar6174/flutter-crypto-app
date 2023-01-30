import 'package:crypto_app/core/failures/http_failure.dart';
import 'package:crypto_app/core/either/either.dart';
import 'package:crypto_app/features/features.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  final ExchangeRemoteDataSourceImpl remoteDataSource;

  ExchangeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<HttpRequestFailure, List<Crypto>>> getPrices(List<String> ids) {
    return remoteDataSource.getPrices(ids);
  }
}
