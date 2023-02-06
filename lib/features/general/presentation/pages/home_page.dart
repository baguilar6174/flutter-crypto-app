import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeRepository exchangeRepository = context.read();
    return ChangeNotifierProvider(
      create: (_) => PricesBloc(
        exchangeRepository: exchangeRepository,
        wsRepository: context.read(),
      )..init(),
      builder: (context, _) {
        final PricesBloc bloc = context.watch<PricesBloc>();
        return Scaffold(
          backgroundColor: const Color(0xffF2F5F8),
          appBar: const MyAppBar(),
          body: Column(
            children: [
              bloc.state.when<Widget>(
                loading: () => const Loader(),
                error: (failure) => Error(failure: failure),
                loaded: (prices, _) => Prices(prices: prices),
              ),
              Text(
                // DateFormat('EEEE yyyy/MM/dd hh:mm:ss a').format(DateTime.now()),
                DateFormat.yMEd().format(DateTime.now()),
              ),
            ],
          ),
        );
      },
    );
  }
}
