import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';

class PricesBloc extends ChangeNotifier {
  PricesBloc({
    required this.exchangeRepository,
    required this.wsRepository,
  });

  final ExchangeRepository exchangeRepository;
  final WsRepository wsRepository;

  // ! Both ways are correct
  // PricesState _state = const LoadingPricesState();
  PricesState _state = const PricesState.loading();

  PricesState get state => _state;

  final _ids = [
    "bitcoin",
    "ethereum",
    "monero",
    "litecoin",
    "usd-coin",
    "dogecoin",
  ];

  Future<void> init() async {
    if (state is! LoadingPricesState) {
      _state = const LoadingPricesState();
      notifyListeners();
    }
    final result = await exchangeRepository.getPrices(_ids);

    _state = result.when(
      left: (failure) => ErrorPricesState(failure),
      right: (prices) {
        startPricesListening();
        return LoadedPricesState(prices: prices);
      },
    );
    notifyListeners();
  }

  Future<bool> startPricesListening() async {
    final connected = await wsRepository.connect(_ids);

    WsStatus wsStatus =
        connected ? const WsStatus.connected() : const WsStatus.error();

    state.whenOrNull(loaded: (prices, _) {
      _state = PricesState.loaded(
        prices: prices,
        wsStatus: wsStatus,
      );
      notifyListeners();
    });
    return connected;
  }
}
