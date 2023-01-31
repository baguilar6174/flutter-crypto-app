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
            appBar: AppBar(
              title: bloc.state.whenOrNull(loaded: (_, wsStatus) {
                return Text(
                  wsStatus.when(
                    connecting: () => 'connecting',
                    connected: () => 'connected',
                    error: () => 'error',
                  ),
                );
              }),
            ),
            body: bloc.state.when<Widget>(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (failure) {
                final String message = failure.when(
                  network: () => 'Check your internet connection',
                  notFound: () => 'Resource not found',
                  server: () => 'Server error',
                  unauthorized: () => 'Unauthorized',
                  badRequest: () => 'Bad Request',
                  local: () => 'Unknown error',
                );
                return Center(
                  child: Text(message),
                );
              },
              loaded: (prices, _) => ListView.builder(
                itemCount: prices.length,
                itemBuilder: (_, index) {
                  final crypto = prices[index];
                  return ListTile(
                    title: Text(crypto.id),
                    subtitle: Text(crypto.symbol),
                    trailing: Text(crypto.price.toStringAsFixed(2)),
                  );
                },
              ),
            ));
      },
    );
  }
}
