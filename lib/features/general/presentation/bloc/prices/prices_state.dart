import 'package:crypto_app/features/features.dart';

abstract class PricesState {}

class PricesInitial extends PricesState {}

class LoadingPricesState extends PricesState {}

class LoadedPricesState extends PricesState {
  final List<Crypto> prices;
  LoadedPricesState({required this.prices});
}

class ErrorPricesState extends PricesState {}
