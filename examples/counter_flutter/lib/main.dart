import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart' hide StateSetter;

// Define the events
class IncrementEvent {}

class DecrementEvent {}

// Create [EventHandlers]
// EventHandlers are intended to contain the business logic of your application.

// Extends the EventHandler class and pass the Tstate and Tevent type params
class IncrementEventHandler extends EventHandler<int, IncrementEvent> {
  @override
  void call(IncrementEvent event) {
    // Uses the setState and getState methods to work with state.
    setState(getState() + 1);
  }
}

class DecrementEventHandler extends EventHandler<int, DecrementEvent> {
  @override
  void call(DecrementEvent event) {
    setState(getState() - 1);
  }
}

// Create an [Etos] instance
final etos = Etos(state: 0)
  // Add the [EventHandler]s for each event
  ..on<IncrementEvent>(IncrementEventHandler())
  ..on<DecrementEvent>(DecrementEventHandler());

void main() {
  runApp(EtosInspector(
    enabled: true,
    etos: etos,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // You can wrap your application in an EtosProvider.
    // This will make it possible to get the Etos from context using
    // EtosProvider.of(context) and it will
    // make the other convinient widgets like EtosBuilder find the Etos
    // automatically as well!
    return EtosProvider<int>(
      etos: etos,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    // Use StateListeners if you want to perform an action based on a state
    // change. Like showing a dialog!
    return StateListener<int, int>(
      converter: (state) => state,
      listener: (context, oldState, state) async {
        if (state % 5 != 0) return;
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Reached: $state'),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        // ... or a SnackBar
        body: EventListener(
          listener: (context, state) =>
              ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Event: $state'),
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                // For building the UI you can use StateBuilders.
                // Etos states are comming from the Etos.states so you could
                // also use a StreamBuilder if you'd like.
                StateBuilder<int, String>(
                  converter: (state) => state.toString(),
                  builder: (context, value) => Text(
                    value,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                )
              ],
            ),
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
              // Or if you are using EtosProvider you can also get it from scope.
              // The easiest way is to use the BuildContext extensions as shown below.
              //
              // You could also call EtosProvider directly:
              // `EtosProvider.of(context).dispatch(DecrementEvent())`
              onPressed: () => context.dispatch(DecrementEvent()),
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ),
    );
  }
}
