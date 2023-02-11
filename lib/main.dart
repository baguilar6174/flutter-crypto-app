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

class MyApp extends StatefulWidget {
  const MyApp(
      {super.key, required this.languageCode, required this.countryCode});
  final String languageCode;
  final String countryCode;

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Locale _locale;
  Locale get locale => _locale;

  @override
  void initState() {
    super.initState();
    _locale = Locale(widget.languageCode, widget.countryCode);
    _locale = L10n.all.firstWhere(
      (e) =>
          e.languageCode == _locale.languageCode &&
          e.countryCode == _locale.countryCode,
      orElse: () => L10n.all.first,
    );
  }

  void changeLanguaje(Locale locale) {
    setState(() {
      if (locale.countryCode?.isNotEmpty ?? false) {
        Intl.defaultLocale = '${locale.languageCode}_${locale.countryCode}';
      } else {
        Intl.defaultLocale = locale.languageCode;
      }
      _locale = locale;
    });
  }

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
      locale: _locale,
      home: const HomeView(),
    );
  }
}
