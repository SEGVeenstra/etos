import 'package:etos/etos.dart';
import 'package:flutter/material.dart';

// Define the events
class IncrementEvent {}

class DecrementEvent {}

// Create [EventHandlers]

// can be a function:
int increment(Object event, int state) => state + 1;

// or even a class:
class DecrementHandler {
  int call(_, int state) {
    return state - 1;
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
            // We can use a Streambuilder to react to state changes
            StreamBuilder<int>(
                // Use the state [Stream]
                stream: etos.state,
                builder: (context, snapshot) {
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
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
