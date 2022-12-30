import 'dart:async';

import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

final _logger = Logger('Etos');

abstract class EventHandler<Tstate, Tevent> {
  const EventHandler();

  FutureOr<void> call(
    Tevent event,
    StateGetter<Tstate> getState,
    StateSetter<Tstate> setState,
  );
}

typedef EtosHandler<Tstate extends Object, Tevent extends Object>
    = FutureOr<void> Function(
  Tevent event,
  StateGetter<Tstate> get,
  StateSetter<Tstate> set,
);

typedef StateGetter<T> = T Function();
typedef StateSetter<T> = void Function(T newState);

class Etos<Tstate extends Object> {
  final _eventHandlers = <Type, EtosHandler<Tstate, Object>>{};
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

  void on<Tevent extends Object>(EtosHandler<Tstate, Tevent> handler) {
    if (_eventHandlers[Tevent] != null) {
      _logger.warning('Tried adding an EventHandler for $Tevent,'
          '\nbut an EventListener has already been registered for $Tevent');
      return;
    }

    _eventHandlers[Tevent] =
        (event, get, set) => handler(event as Tevent, get, set);
    _logger.info('Eventhandler added for $Tevent');
  }

  void dispatch(Object event) async {
    _logger.info('dispatched event\n$event');
    _events.add(event);

    final handler = _eventHandlers[event.runtimeType];

    if (handler == null) {
      _logger.info('No handler found for events of type ${event.runtimeType}!');
      return;
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
