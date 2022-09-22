import 'package:etos/etos.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

Future<void> main() async {
  late Etos<int> etos;

  setUp(() {
    etos = Etos<int>(state: 0)
      ..on<IncrementEvent>((event, getter, setter) async {
        Future.delayed(Duration(seconds: 1));
        setter(getter() + 1);
      })
      ..on<AddEvent>(AddHandler())
      ..on<DecrementEvent>(
        (event, stateGetter, stateSetter) {
          stateSetter(stateGetter() - 1);
        },
      );
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
}

class AddHandler {
  Future<void> call(
      AddEvent event, StateGetter<int> get, StateSetter<int> set) async {
    for (var i = 0; i < event.number; i++) {
      await Future.delayed(Duration(milliseconds: 100));
      final newState = get() + 1;
      set(newState);
    }
  }
}

class IncrementEvent {}

class DecrementEvent {}

class AddEvent {
  final int number;

  const AddEvent(this.number);
}
