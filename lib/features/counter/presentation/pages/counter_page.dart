import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _bloc = CounterBloc(0);

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: _bloc.stream,
          initialData: _bloc.state,
          builder: (_, snapshot) => Text(
            '${_bloc.state}',
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _bloc.add(IncrementEvent());
        },
      ),
    );
  }
}
