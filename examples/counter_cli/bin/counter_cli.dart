import 'dart:async';

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

class IncrementEventHandler extends EventHandler<int, IncrementEvent> {
  @override
  FutureOr<void> call(IncrementEvent event) {
    // Use setState and getState to work with state
    setState(getState() + 1);
  }
}

class DecrementEventHandler extends EventHandler<int, DecrementEvent> {
  // You can override the callWhen method
  @override
  bool callWhen(int state) => state > 0;

  @override
  FutureOr<void> call(DecrementEvent event) {
    setState(getState() - 1);
  }
}

void main() {
  // Setup logger
  Logger.root.onRecord.listen((event) {
    // Etos usses the Logging package to log usefull information like
    // State updates and Events that are being emitted!
    print('[' +
        event.level.name +
        '] ' +
        event.loggerName +
        ': ' +
        event.message);
  });

  final etos = Etos<int>(state: 0);

  etos.states.listen((state) {
    // Here you can use the state!
  });

  etos.on<IncrementEvent>(IncrementEventHandler());
  etos.on<DecrementEvent>(DecrementEventHandler());

  // Is being ignored because IncrementEvent already has an EventHandler (warning logged)
  etos.on<IncrementEvent>(IncrementEventHandler());

  etos.dispatch(IncrementEvent()); // 1
  etos.dispatch(IncrementEvent()); // 2
  etos.dispatch(DecrementEvent()); // 1
  etos.dispatch(IncrementEvent()); // 2
  etos.dispatch(DecrementEvent()); // 1
  etos.dispatch(DecrementEvent()); // 0
  etos.dispatch(
      DecrementEvent()); // Ignorred because of the `callWhen`-condition!
}
