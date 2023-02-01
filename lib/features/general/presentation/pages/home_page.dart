import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeRepository exchangeRepository =
        context.read<ExchangeRepository>();
    return ChangeNotifierProvider(
      create: (_) => PricesBloc(
        exchangeRepository: exchangeRepository,
        wsRepository: context.read(),
      )..init(),
      builder: (context, _) {
        final PricesBloc bloc = context.watch<PricesBloc>();
        return Scaffold(
          appBar: const MyAppBar(),
          body: bloc.state.when<Widget>(
            loading: () => const Loader(),
            error: (failure) => Error(failure: failure),
            loaded: (prices, _) => Prices(prices: prices),
          ),
        );
      },
    );
  }
}
