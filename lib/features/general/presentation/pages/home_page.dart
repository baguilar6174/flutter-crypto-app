import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:crypto_app/features/features.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeRepository exchangeRepository = context.read();
    return BlocProvider<PricesBloc>(
      create: (_) => PricesBloc(
        const PricesState.loading(),
        exchangeRepository: exchangeRepository,
        wsRepository: context.read(),
      )..add(const InitializeEvent()),
      child: Builder(
        builder: (context) {
          final PricesBloc bloc = context.watch<PricesBloc>();
          return Scaffold(
            backgroundColor: const Color(0xffF2F5F8),
            appBar: const MyAppBar(),
            body: bloc.state.when<Widget>(
              loading: () => const Loader(),
              error: (failure) => Error(failure: failure),
              loaded: (prices, _) => Prices(prices: prices),
            ),
          );
        },
      ),
    );
  }
}
