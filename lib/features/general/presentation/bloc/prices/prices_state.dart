import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:crypto_app/core/core.dart';
import 'package:crypto_app/features/features.dart';

part 'prices_state.freezed.dart';

@freezed
class PricesState with _$PricesState {
  const factory PricesState.loading() = LoadingPricesState;
  const factory PricesState.error(HttpRequestFailure failure) =
      ErrorPricesState;
  const factory PricesState.loaded({
    required List<Crypto> prices,
    @Default(WsStatus.connecting()) WsStatus wsStatus,
  }) = LoadedPricesState;
}

@freezed
class WsStatus with _$WsStatus {
  const factory WsStatus.connecting() = ConnectingWsStatus;
  const factory WsStatus.connected() = ConnectedWsStatus;
  const factory WsStatus.error() = ErrorWsStatus;
}
