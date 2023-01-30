import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:crypto_app/core/core.dart';
import 'package:crypto_app/features/features.dart';

part 'prices_state.freezed.dart';

@freezed
class PricesState with _$PricesState {
  factory PricesState.loading() = LoadingPricesState;
  factory PricesState.error(HttpRequestFailure failure) = ErrorPricesState;
  factory PricesState.loaded(List<Crypto> prices) = LoadedPricesState;
}
