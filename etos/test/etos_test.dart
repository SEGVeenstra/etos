import 'dart:async';

import 'package:etos/etos.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

Future<void> main() async {
  late Etos<int> etos;

  setUp(() {
    etos = Etos<int>(state: 0)
      ..on<IncrementEvent>(IncrementEventHandler())
      ..on<AddEvent>(AddHandler())
      ..on<DecrementEvent>(DecrementEventHandler());
  });

  test('simple test', () {
    expect(etos.state, 0);

    expect(etos.states, emitsInOrder([0, 1]));

    etos.dispatch(IncrementEvent());
  });

  test('async test', () {
    expect(etos.state, 0);

    expect(etos.states, emitsInOrder([0, 1, 2, 3, 4, 5]));

    etos.dispatch(AddEvent(5));
  });

  test('mixed test', () async {
    expect(etos.state, 0);

    expect(etos.states, emitsInOrder([0, 1, 2, 1, 2, 3, 4]));

    etos.dispatch(AddEvent(5));

    await Future.delayed(Duration(milliseconds: 250));

    etos.dispatch(DecrementEvent());
  });

  test('canCall test', () async {
    expect(etos.states, emitsInOrder([0, 1, 0]));

    etos.dispatch(IncrementEvent());
    etos.dispatch(DecrementEvent());
    etos.dispatch(DecrementEvent());
  });
}

class IncrementEvent {}

class DecrementEvent {}

class AddEvent {
  final int number;

  const AddEvent(this.number);
}

class IncrementEventHandler extends EventHandler<int, IncrementEvent> {
  @override
  FutureOr<void> call(IncrementEvent event) {
    Future.delayed(Duration(seconds: 1));
    setState(getState() + 1);
  }
}

class DecrementEventHandler extends EventHandler<int, DecrementEvent> {
  @override
  bool callWhen(int state) => state > 0; // can not decrement below 0

  @override
  FutureOr<void> call(DecrementEvent event) {
    setState(getState() - 1);
  }
}

class AddHandler extends EventHandler<int, AddEvent> {
  @override
  Future<void> call(AddEvent event) async {
    for (var i = 0; i < event.number; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      final newState = getState() + 1;
      setState(newState);
    }
  }
}
