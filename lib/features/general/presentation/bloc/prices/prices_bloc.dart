import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';
import 'package:crypto_app/features/general/presentation/bloc/bloc.dart';

class PricesBloc extends ChangeNotifier {
  PricesBloc({required this.repository});

  final ExchangeRepository repository;

  // ! Both ways are correct
  // PricesState _state = LoadingPricesState();
  PricesState _state = PricesState.loading();

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

    _state = result.when(
      left: (failure) => ErrorPricesState(failure),
      right: (prices) => LoadedPricesState(prices),
    );

    notifyListeners();
  }
}
