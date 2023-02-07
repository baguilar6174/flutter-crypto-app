import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/core/core.dart';
import 'package:crypto_app/features/features.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'es_EC';
  final esES = numberFormatSymbols['es_ES'] as NumberSymbols;
  numberFormatSymbols['es_ES'] = esES.copyWith(currencySymbol: '€');
  final enUS = numberFormatSymbols['en_US'] as NumberSymbols;
  numberFormatSymbols['en_US'] = enUS.copyWith(currencySymbol: r'$');
  numberFormatSymbols['es_EC'] = enUS.copyWith(currencySymbol: r'$');

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
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        Strings.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ], // allow widgets support multiples languajes
      supportedLocales: L10n.all,
      locale: const Locale('es'),
      home: const HomeView(),
    );
  }
}
