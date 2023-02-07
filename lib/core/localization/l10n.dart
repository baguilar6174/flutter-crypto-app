import 'package:flutter/material.dart';

class L10n {
  L10n._();

  static final all = [
    const Locale('en'),
    const Locale('es'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'es':
        return 'Espanish';
      case 'en':
      default:
        return 'English';
    }
  }
}
