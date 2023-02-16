Etos is an event-driven application state management solution, focussed on simplicity.

```
NOTE:
This package is still in development and I discourage anyone from using it in production software!

BUT, if you're just going to experiment and need a quick and easy way to manage state, be my guest to use Etos. I would love to get your feedback!
```

## Why Etos?

`Etos` is the result of an experiment to see how far I could go without a state management package like `riverpod`, `bloc` and `redux` when building an app.

`Etos` was intended for personal use but since I was very happy with the result, I ironically decided to turn it into a state management package of my own.

## About Etos

`Etos` stands for **E**vent-**to**-**s**tate and is an *event-driven state management solution* designed to easy work with and manage **app state**.

With `Etos` you manage a single state object, similar to redux, because in my experience, a single state object is easier to manage then when state is scattered.

To change the state you dispatch **events**, which `Etos` will match with `EventHandlers` that you register with your `Etos` instance.

## Components

`Etos` consists of a few components which each play a specific role. Let's take a closer look at each of them.

### State

`Etos` is all about state management. Because `Etos` uses a single state object you need to think about how to structure this state.

Your state can be a simple `int` for something like the Counter App, or a complex `Object`.

### Etos

Your app will have a single `Etos` instance which will hold the state for your app. It exposes a `Stream` on which new versions of the state will be emitted, and which can be used to update your interface.

### Events

Events are just normal `Object`s which you can submit to `Etos` to initiate change.

### EventHandlers

The whole idea of this package has evolved around the `EventHandlers`. `EventHandlers` are triggered by **events** and are meant to *contain all the logic for a specific event*.

## Setup

Using `Etos` is easy. In the following sections I'll show you how to work with `Etos`.

### AppState

You first need to think about what kind of state you want to manage. It can be a simple primitive, but for the avarage app that will not be enough. Therefor I suggest to start with creating an `Object`, which we conveniently call `AppState`.

We will look at the Flutter counter app for this example. So our state needs an `int` field to keep track of the count.

> TIP: Use the freezed package to make manipulating your state object easier.

```dart
class AppState {
    final int counter;

    const AppState(this.count);
}
```

### Event

The counter app only has one functionality, which is incrementing the number. So let's create an event for that.

```dart
class IncrementEvent {}
```

### EventHandler

Next we need to define an `EventHandler` that is executed whenever the `IncrementEvent` is dispatched. It should update the state with an incremented count.

```dart
class IncrementEventHandler extends EventHandler<AppState,IncrementEvent> {

    FutureOr<void> call(IncrementEvent event) {
        // get the current state
        final currentState = getState();

        // set a new state
        setState(AppState(currentState.counter + 1));
    }
}
```

### Etos instance

With our `AppState`, `Event` and `EventHandler` defined we can create our `Etos` instance and pass it an initial state and add the `EventHandler`.

```dart
final etos = Etos(state: AppState(0));
etos.on<IncrementEvent>(IncrementEventHandler());
```

That's it, we've now setup `Etos` for our project!

## Usage

In the previous section we've setup `Etos`. In this section I will show you how to use it.

### Using Etos

Our `Etos` instance exposes two `Stream`s that you can use in your interface.

```dart
// Use the `states` stream to listen for state updates
etos.states.listen((state) => print('Current count: ${state.counter}'));

// Use the `events` stream to listen for events that are being dispatched
etos.events.listen((event) => print('Event dispatched: $event'));
```

Use `.states` for persistent changes, like a our counter. If you want to show a one-time message, like a toast or snackbar when something has happend which has no impact on the state, you can use `.events`.

### Dispatching events

Nothing is going to happen as long as we're not dispatching any **events**. To increment our counter, all we have to do is dispatch the `IncrementEvent`.

```dart
etos.dispatch(IncrementEvent());
```

That's it, that's all you need to know to get started with `Etos`.

### Logging

On of the mayor benefits of being an event-driven solution, is that all the information is passing to a single object.

Both events and states are managed by `Etos`, which means `Etos` knows everything that's going on.

This makes it very convinient for `Etos` to log all this information. for this, `Etos` is using the `logging` package. All you have to do is setup logging (or if you already have it setup, it will automatically work).

```dart
Logger.root.onRecord.listen((log) {
    debugPrint(log.toString());
  });
```

## Additional information

Coming soon.
