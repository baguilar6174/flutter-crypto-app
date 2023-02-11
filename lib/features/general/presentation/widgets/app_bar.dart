import 'package:crypto_app/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_app/features/features.dart';
import 'package:crypto_app/core/core.dart';

class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final PricesBloc bloc = context.watch();
    final state = context.findAncestorStateOfType<MyAppState>();
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
          value: state?.locale,
          items: [
            DropdownMenuItem(
              value: const Locale('en'),
              child: Text(Strings.of(context)!.lanEn),
            ),
            DropdownMenuItem(
              value: const Locale('es'),
              child: Text(Strings.of(context)!.lanEs),
            ),
          ],
          onChanged: (locale) {
            if (locale != null) {
              state?.changeLanguaje(locale);
            }
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
