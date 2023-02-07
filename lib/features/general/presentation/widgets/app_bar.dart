import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';
import 'package:crypto_app/core/core.dart';

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
          items: [
            DropdownMenuItem(
              value: const Locale('en', 'US'),
              child: Text(Strings.of(context)!.lanEn),
            ),
            DropdownMenuItem(
              value: const Locale('es', 'ES'),
              child: Text(Strings.of(context)!.lanEs),
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
