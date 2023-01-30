import 'dart:io';

import 'package:crypto_app/core/core.dart';
import 'package:crypto_app/features/common/data/data.dart';
import 'package:crypto_app/features/features.dart';
import 'package:crypto_app/utils/utils.dart';

abstract class ExchangeRemoteDataSource {
  // TODO: create type for Future<Either<HttpRequestFailure, List<Crypto>>>
  Future<Either<HttpRequestFailure, List<Crypto>>> getPrices(List<String> ids);
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  final DioClient _client;

  ExchangeRemoteDataSourceImpl(this._client);

  @override
  Future<Either<HttpRequestFailure, List<Crypto>>> getPrices(
      List<String> ids) async {
    try {
      final response = await _client.getRequest(
        ListApi.assets,
        queryParameters: {"ids": ids.join(",")},
      );

      if (response.statusCode == 200) {
        final cryptos = (response.data["data"] as List).map(
          (e) => Crypto(
            id: e["id"],
            symbol: e["symbol"],
            price: double.parse(e["priceUsd"]),
          ),
        );
        return Either.right(cryptos.toList());
      }

      if (response.statusCode == 404) {
        throw HttpRequestFailure.notFound();
      }

      if (response.statusCode! >= 500) {
        throw HttpRequestFailure.server();
      }

      throw HttpRequestFailure.local();
    } catch (e) {
      late HttpRequestFailure failure;
      if (e is HttpRequestFailure) {
        failure = e;
      } else if (e is SocketException) {
        failure = HttpRequestFailure.network();
      } else {
        failure = HttpRequestFailure.local();
      }
      return Either.left(failure);
    }
  }
}
