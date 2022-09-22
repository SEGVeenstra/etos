import 'dart:async';

import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

final _logger = Logger('Etos');

typedef EtosHandler<Tstate extends Object> = FutureOr<void> Function(
  Object event,
  StateGetter get,
  StateSetter set,
);

typedef StateGetter<T> = T Function();
typedef StateSetter<T> = void Function(T newState);

class Etos<Tstate extends Object> {
  final _eventHandlers = <Type, EtosHandler<Tstate>>{};
  final _states = BehaviorSubject<Tstate>();
  final _events = StreamController<Object>();

  /// A stream with the states
  ///
  /// On listening will give you the current state
  Stream<Tstate> get states => _states.stream..asBroadcastStream();
  Stream<Object> get events => _events.stream.asBroadcastStream();

  Tstate get state => _states.value;

  Etos({required Tstate state}) {
    _logger.info('Creeated with initial state:\n$state');
    _states.add(state);
  }

  void on<Tevent extends Object>(
      FutureOr<void> Function(
    Tevent event,
    StateGetter<Tstate> getState,
    StateSetter<Tstate> setState,
  )
          handler) {
    if (_eventHandlers[Tevent] != null) {
      _logger.warning('Tried adding an EventHandler for $Tevent,'
          '\nbut an EventListener has already been registered for $Tevent');
      return;
    }

    _eventHandlers[Tevent] = (event, get, set) =>
        handler(event as Tevent, get as StateGetter<Tstate>, set);
    _logger.info('Eventhandler added for $Tevent');
  }

  void dispatch(Object event) async {
    _logger.info('dispatched event\n$event');
    _events.add(event);

    final handler = _eventHandlers[event.runtimeType];

    if (handler == null) {
      throw 'No handler found for events of type ${event.runtimeType}!';
    }

    await handler.call(
      event,
      () => state,
      _setState,
    );
  }

  void _setState(newState) {
    _states.add(newState);
    _logger.info('state updated\n$newState');
  }
}
