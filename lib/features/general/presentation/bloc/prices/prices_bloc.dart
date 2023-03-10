import 'dart:async';

import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';

class PricesBloc extends ChangeNotifier {
  PricesBloc({
    required this.exchangeRepository,
    required this.wsRepository,
  });

  final ExchangeRepository exchangeRepository;
  final WsRepository wsRepository;

  StreamSubscription? _subscription;
  StreamSubscription? _wsSubscription;

  // ! Both ways are correct
  // PricesState _state = const LoadingPricesState();
  PricesState _state = const PricesState.loading();

  PricesState get state => _state;

  final _ids = [
    "bitcoin",
    "ethereum",
    "tether",
    "binance-coin",
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

    state.mapOrNull(
      loaded: (state) {
        if (connected) {
          _onPricesChanged();
        }
        _state = state.copyWith(
          wsStatus: wsStatus,
        );
        notifyListeners();
      },
    );
    return connected;
  }

  void _onPricesChanged() {
    _subscription?.cancel();
    _wsSubscription?.cancel();

    _subscription = wsRepository.onPricesChanged.listen((changes) {
      state.mapOrNull(
        loaded: (state) {
          // ! Creating a copy from prices
          // final prices = List<Crypto>.from(state.prices);
          List<Crypto> prices = [...state.prices];
          final keys = changes.keys;

          prices = prices.map((price) {
            if (keys.contains(price.id)) {
              return price.copyWith(price: changes[price.id]!);
            }
            return price;
          }).toList();

          _state = state.copyWith(prices: prices);
          notifyListeners();
        },
      );
    });
    _wsSubscription = wsRepository.onStatusChanged.listen((status) {
      state.mapOrNull(
        loaded: (state) {
          _state = state.copyWith(wsStatus: status);
        },
      );
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _wsSubscription?.cancel();
    super.dispose();
  }
}
