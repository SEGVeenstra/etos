Etos is an event-driven application management solution

```
NOTE:
This package is still in development and I discourage anyone from using it in production production software!
```

# etos
Etos is an event-driven state management package for Dart.

## Usage
Etos works by dispatching events to event handlers, which in turn can update the state of the Etos.

To use Etos, first create an Etos instance by passing in the initial state:

```dart
final etos = Etos<MyState>(state: MyState.initial());
```

Then add event handlers to the Etos instance using the on method:

```dart
etos.on<MyEvent>(MyEventHandler());
```

Finally, dispatch events to the Etos instance to update the state:

```dart
etos.dispatch(MyEvent());
```

## Event Handlers
Event handlers should extend the EventHandler class and implement the call method.

```dart
class MyEventHandler extends EventHandler<MyState, MyEvent> {
  @override
  FutureOr<void> call(MyEvent event) async {
    // Update the state...
    setState(getState().copyWith(/* ... */));
  }
}
```
Optionally, you can implement the callWhen method to decide if the handler should be called based on the current state:

``` dart
class MyEventHandler extends EventHandler<MyState, MyEvent> {
  @override
  bool callWhen(MyState state) {
    return state.shouldHandleMyEvent;
  }

  @override
  FutureOr<void> call(MyEvent event) async {
    // Update the state...
    setState(getState().copyWith(/* ... */));
  }
}
```
## State Updates
To update the state of the Etos instance, call the setState method from an event handler:

```dart
setState(getState().copyWith(/* ... */));
```

The getState method returns the current state of the Etos instance.

## Streams
Etos provides streams for accessing the current state and events. These streams can be listened to like any other Dart stream:

```dart
final stateSubscription = etos.states.listen((state) {
  // Handle new state...
});

final eventsSubscription = etos.events.listen((event) {
  // Handle new event...
});
```

## License
Etos is licensed under the BSD 3-Clause License. See the LICENSE file for details.
