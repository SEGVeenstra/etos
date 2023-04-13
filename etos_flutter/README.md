# etos_flutter
etos_flutter is a package that provides several widgets to help with integrating the etos state management library with Flutter.

This readme explains the widgets this package provides to work with etos. For more general knowledge about etos, check out it's readme.

## Widgets
This package contains the following widgets.

### EtosProvider
A widget that provides an Etos object to the widget tree. Often added at the very top of the Widget tree.

```dart
EtosProvider<CounterState>(
  etos: etos,
  child: MyApp(),
)
```

### StateBuilder
A widget that rebuilds whenever a state in the Etos object changes.

```dart
StateBuilder<CounterState>(
  etos: etos, // optional, if not provided, StateBuilder will try to get it from context
  converter: (state) => state.count,
  builder: (context, state) => Text('Count: ${state.count}'),
)
```

### StateListener
A widget that listens to changes of a specific state and triggers a callback. StateListeners are ideal to trigger one-off
operations like showing a Snackbar or doing navigation.

```dart
StateListener<CounterState, int>(
  etos: etos, // optional, if not provided, StateBuilder will try to get it from context
  converter: (state) => state.count,
  listener: (context, oldValue, newValue) {
    // do something
  },
  child: Container(),
)
```

### EventListener
A widget that listens to all events from the Etos object and triggers a callback. Event listeners, 
just like StateListeners, work best for triggering one-off operations. The big difference is that with EventListeners you
don't have to update state to trigger them.

```dart
EventListener<CounterState>(
  etos: etos, // optional, if not provided, StateBuilder will try to get it from context
  listener: (context, event) {
    // do something
  },
  child: Container(),
)
```

## License
Etos is licensed under the BSD 3-Clause License. See the LICENSE file for details.
