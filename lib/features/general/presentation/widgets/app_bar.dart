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
      actions: [
        DropdownButton(
          value: const Locale('en', 'US'),
          items: const [
            DropdownMenuItem(
              value: Locale('en', 'US'),
              child: Text('English'),
            ),
            DropdownMenuItem(
              value: Locale('es', 'ES'),
              child: Text('Español'),
            ),
            DropdownMenuItem(
              value: Locale('es', 'EC'),
              child: Text('Español Ecuador'),
            ),
          ],
          onChanged: (_) {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
