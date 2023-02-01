import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

const colors = <String, Color>{
  'BTC': Colors.orange,
  'ETH': Colors.deepPurple,
  'USDT': Colors.green,
  'BNB': Colors.yellow,
  'USDC': Colors.blue,
  'DOGE': Colors.deepOrange,
  'LTC': Colors.grey,
  'XMR': Colors.deepOrangeAccent,
};

class Prices extends StatelessWidget {
  const Prices({super.key, required this.prices});
  final List<Crypto> prices;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(5),
      itemCount: prices.length,
      itemBuilder: (_, index) {
        final crypto = prices[index];
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            tileColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            leading: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/${crypto.symbol}.svg',
                  width: 30,
                  height: 30,
                  color: colors[crypto.symbol],
                ),
              ],
            ),
            title: Text(
              crypto.name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(crypto.symbol),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  NumberFormat.currency(name: r'$').format(crypto.price),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${crypto.changePercent24Hr.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: crypto.changePercent24Hr.isNegative
                        ? Colors.redAccent
                        : Colors.greenAccent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
