import 'package:etos/etos.dart';
import 'package:logging/logging.dart';

class IncrementEvent {
  @override
  String toString() => 'IncrementEvent';
}

class DecrementEvent {
  @override
  String toString() => 'DecrementEvent';
}

void main() {
  // Setup logger
  Logger.root.onRecord.listen((event) {
    //print(event);
  });

  final etos = Etos<int>(state: 0);

  etos.state.listen((state) {
    print(state);
  });

  etos.on<IncrementEvent>((event, state) => state + 1);
  etos.on<DecrementEvent>((event, state) => state - 1);

  // Is being ignored (warning logged)
  etos.on<IncrementEvent>((event, state) => state + 1);

  etos.dispatch(IncrementEvent());
  etos.dispatch(IncrementEvent());
  etos.dispatch(DecrementEvent());
  etos.dispatch(IncrementEvent());
}
