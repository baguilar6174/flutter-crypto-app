import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<ExchangeRepository>(
        create: (_) => ExchangeRepositoryImpl(
          remoteDataSource: ExchangeRemoteDataSourceImpl(DioClient()),
        ),
      ),
      Provider<WsRepository>(
        create: (_) => WsRepositoryImpl(
          (ids) => WebSocketChannel.connect(Uri.parse(
            "wss://ws.coincap.io/prices?assets=${ids.join(',')}",
          )),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeView(),
      debugShowCheckedModeBanner: false,
    );
  }
}
