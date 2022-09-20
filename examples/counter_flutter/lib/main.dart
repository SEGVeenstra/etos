import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart' hide StateSetter;

// Define the events
class IncrementEvent {}

class DecrementEvent {}

// Create [EventHandlers]

// can be a function:
void increment(Object event, StateGetter<int> get, StateSetter<int> set) =>
    set(get() + 1);

// or even a class:
class DecrementHandler {
  void call(_, StateGetter<int> get, StateSetter<int> set) {
    return set(get() - 1);
  }
}

// Create an [Etos] instance
final etos = Etos(state: 0)
  // Add [EventHandler]s
  ..on<IncrementEvent>(increment)
  ..on<DecrementEvent>(DecrementHandler());

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // We can use an EtosBuilder to listen to changes
            EtosBuilder<int>(
              etos: etos,
              builder: (context, state) => Text(
                '$state',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            // Dispatch events via your global [Etos] instance
            onPressed: () => etos.dispatch(IncrementEvent()),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => etos.dispatch(DecrementEvent()),
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
