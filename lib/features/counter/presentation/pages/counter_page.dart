import 'package:flutter/material.dart';

import 'package:crypto_app/features/features.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  final _cubit = CounterCubit();

  @override
  void dispose() {
    _cubit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder<int>(
          stream: _cubit.stream,
          initialData: _cubit.state,
          builder: (_, snapshot) => Text(
            '${_cubit.state}',
            style: const TextStyle(fontSize: 25),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cubit.increment();
        },
      ),
    );
  }
}
