import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';
import 'package:crypto_app/features/general/presentation/bloc/bloc.dart';

class PricesBloc extends ChangeNotifier {
  PricesBloc({required this.repository});

  final ExchangeRepository repository;

  PricesState _state = LoadingPricesState();
  PricesState get state => _state;

  Future<void> init() async {
    if (state is! LoadingPricesState) {
      _state = LoadingPricesState();
      notifyListeners();
    }
    final result = await repository.getPrices([
      "bitcoin",
      "ethereum",
      "monero",
      "litecoin",
      "usd-coin",
      "dogecoin",
    ]);
    if (result is GetPricesSuccess) {
      _state = LoadedPricesState(prices: result.cryptos);
    } else {
      _state = ErrorPricesState();
    }
    notifyListeners();
  }
}
