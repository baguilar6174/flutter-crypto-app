import 'dart:async';

// * Events
abstract class CounterEvent {
  final int factor;
  CounterEvent(this.factor);
}

class IncrementEvent extends CounterEvent {
  IncrementEvent(super.factor);
}

class DecrementEvent extends CounterEvent {
  DecrementEvent(super.factor);
}

class CounterBloc {
  // * This is the state
  int _counter = 0;
  int get counter => _counter;

  // * To notify the view
  final _controller = StreamController<int>.broadcast();
  Stream<int> get stream => _controller.stream;

  void operation(CounterEvent event) {
    if (event is IncrementEvent) {
      _emit(_counter + event.factor);
    } else if (event is DecrementEvent) {
      _emit(_counter - 1);
    }
  }

  void _emit(int newCounter) {
    if (newCounter != _counter) {
      _counter = newCounter;
      // !Notify
      _controller.add(_counter);
    }
  }

  void dispose() {
    _controller.close();
  }
}
