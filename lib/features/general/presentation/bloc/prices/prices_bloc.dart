import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:crypto_app/features/features.dart';

class PricesBloc extends Bloc<PricesEvent, PricesState> {
  PricesBloc(
    super.initialState, {
    required this.exchangeRepository,
    required this.wsRepository,
  }) {
    on<InitializeEvent>(_onInitialize);
    on<UpdateWsStatusEvent>((event, emit) {
      state.mapOrNull(loaded: (state) {
        emit(state.copyWith(wsStatus: event.status));
      });
    });
    on<UpdateCryptoPricesEvent>((event, emit) {});
    on<DeleteEvent>((event, emit) {});
  }

  final ExchangeRepository exchangeRepository;
  final WsRepository wsRepository;
  StreamSubscription? _subscription;
  StreamSubscription? _wsSubscription;

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

  Future<void> _onInitialize(
    InitializeEvent event,
    Emitter<PricesState> emit,
  ) async {
    if (state is! LoadingPricesState) emit(const LoadingPricesState());
    final result = await exchangeRepository.getPrices(_ids);
    final newState = result.when(
      left: (failure) => ErrorPricesState(failure),
      right: (prices) {
        startPricesListening();
        return LoadedPricesState(prices: prices);
      },
    );
    emit(newState);
  }

  Future<bool> startPricesListening() async {
    final connected = await wsRepository.connect(_ids);
    WsStatus wsStatus =
        connected ? const WsStatus.connected() : const WsStatus.error();
    add(UpdateWsStatusEvent(wsStatus));
    await _wsSubscription?.cancel();
    _wsSubscription = wsRepository.onStatusChanged.listen((status) {
      add(UpdateWsStatusEvent(status));
    });
    return connected;
  }

  void _onPricesChanged(Emitter<PricesState> emit) {
    _subscription?.cancel();
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

          emit(state.copyWith(prices: prices));
        },
      );
    });
    /*  */
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    _wsSubscription?.cancel();
    return super.close();
  }
}
