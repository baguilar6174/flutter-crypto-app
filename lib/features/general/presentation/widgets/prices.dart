import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';

class Prices extends StatelessWidget {
  const Prices({super.key, required this.prices});
  final List<Crypto> prices;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: prices.length,
      itemBuilder: (_, index) {
        final crypto = prices[index];
        return ListTile(
          title: Text(crypto.id),
          subtitle: Text(crypto.symbol),
          trailing: Text(crypto.price.toStringAsFixed(2)),
        );
      },
    );
  }
}
