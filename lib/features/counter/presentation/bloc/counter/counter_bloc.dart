import 'package:crypto_app/features/features.dart';

class CounterBloc extends Bloc<CounterEvents, int> {
  CounterBloc(super.initialState) {
    on<IncrementEvent>(
      (event, emit) => emit(state + 1),
    );
    on<DecrementEvent>(
      (event, emit) => emit(state - 1),
    );
  }
}
