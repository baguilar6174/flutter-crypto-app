import 'package:crypto_app/features/features.dart';

abstract class Bloc<Event, State> extends Cubit<State> {
  Bloc(super.initialState);
}
