import 'package:etos/etos.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

Future<void> main() async {
  late Etos<int> etos;

  setUp(() {
    etos = Etos<int>(state: 0)
      ..on<IncrementEvent>((event, state) async {
        await Future.delayed(Duration(seconds: 1));
        return etos.currentState + 1;
      })
      ..on<AddEvent>((event, state) => state + event.number);
  });

  test('simple test', () {
    expect(etos.currentState, 0);

    expect(etos.state, emitsInOrder([0, 1]));

    etos.dispatch(IncrementEvent());
  });

  test('async test', () {
    expect(etos.currentState, 0);

    expect(etos.state, emitsInOrder([0, 5, 6, 7]));

    etos.dispatch(IncrementEvent());
    etos.dispatch(AddEvent(5));
    etos.dispatch(IncrementEvent());
  });
}

class IncrementEvent {}

class AddEvent {
  final int number;

  const AddEvent(this.number);
}
