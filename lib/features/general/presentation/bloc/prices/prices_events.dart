import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:crypto_app/features/features.dart';

part 'prices_events.freezed.dart';

@freezed
class PricesEvent with _$PricesEvent {
  const factory PricesEvent.initialize() = InitializeEvent;
  const factory PricesEvent.updateWsStatus(WsStatus status) =
      UpdateWsStatusEvent;
  const factory PricesEvent.updateCryptoPrices(Map<String, double> prices) =
      UpdateCryptoPricesEvent;
  const factory PricesEvent.delete(Crypto crypto) = DeleteEvent;
}
