import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final PricesBloc bloc = context.watch();
    return AppBar(
      title: bloc.state.whenOrNull(loaded: (_, wsStatus) {
        return Text(
          wsStatus.when(
            connecting: () => 'connecting',
            connected: () => 'connected',
            error: () => 'error',
          ),
        );
      }),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
