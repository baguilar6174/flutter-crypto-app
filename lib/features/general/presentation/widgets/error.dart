import 'package:flutter/material.dart';

import 'package:crypto_app/core/core.dart';

class Error extends StatelessWidget {
  const Error({super.key, required this.failure});
  final HttpRequestFailure failure;

  @override
  Widget build(BuildContext context) {
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
  }
}
