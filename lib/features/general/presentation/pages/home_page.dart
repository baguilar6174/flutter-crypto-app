import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';
import 'package:crypto_app/features/general/presentation/bloc/bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeRepository repository = context.read<ExchangeRepository>();
    return ChangeNotifierProvider(
      create: (_) => PricesBloc(repository: repository)..init(),
      builder: (context, _) {
        final PricesBloc bloc = context.watch<PricesBloc>();
        return Scaffold(
          body: () {
            final state = bloc.state;
            if (state is LoadingPricesState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadedPricesState) {
              return ListView.builder(
                  itemCount: state.prices.length,
                  itemBuilder: (_, index) {
                    final crypto = state.prices[index];
                    return ListTile(
                      title: Text(crypto.id),
                      subtitle: Text(crypto.symbol),
                      trailing: Text(crypto.price.toStringAsFixed(2)),
                    );
                  });
            }
            return const Center(
              child: Text('error'),
            );
          }(),
        );
      },
    );
  }
}
