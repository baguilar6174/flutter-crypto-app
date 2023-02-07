import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:crypto_app/core/core.dart';
import 'package:crypto_app/features/features.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final systemLanguageCode = ui.window.locale.languageCode;
  final systemCountryCode = ui.window.locale.countryCode;
  String defaultLocale = systemLanguageCode;
  if (systemCountryCode != null) defaultLocale += '_$systemCountryCode';
  Intl.defaultLocale = defaultLocale;
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
    child: MyApp(
      countryCode: systemCountryCode ?? '',
      languageCode: systemLanguageCode,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {super.key, required this.languageCode, required this.countryCode});
  final String languageCode;
  final String countryCode;

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
      locale: Locale(languageCode, countryCode),
      home: const HomeView(),
    );
  }
}
