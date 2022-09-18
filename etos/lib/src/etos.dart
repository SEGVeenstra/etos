import 'dart:async';

import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

final _logger = Logger('Etos');

typedef EtosHandler<Tstate extends Object> = FutureOr<Tstate> Function(
    Object event, Tstate state);

class Etos<Tstate extends Object> {
  final _eventHandlers = <Type, EtosHandler<Tstate>>{};
  final _state = BehaviorSubject<Tstate>();
  final _events = StreamController<Object>();

  Stream<Tstate> get state => _state.stream;
  Stream<Object> get events => _events.stream;

  Tstate get currentState => _state.value;

  Etos({required Tstate state}) {
    _logger.info('Creeated with initial state:\n$state');
    _state.add(state);
  }

  void on<Tevent extends Object>(
      FutureOr<Tstate> Function(Tevent event, Tstate state) handler) {
    if (_eventHandlers[Tevent] != null) {
      _logger.warning('Tried adding an EventHandler for $Tevent,'
          '\nbut an EventListener has already been registered for $Tevent');
      return;
    }

    _eventHandlers[Tevent] =
        (event, state) async => await handler(event as Tevent, state);
    _logger.info('Eventhandler added for $Tevent');
  }

  void dispatch(Object event) async {
    _logger.info('dispatched event\n$event');
    _events.add(event);

    final handler = _eventHandlers[event.runtimeType];

    if (handler == null) {
      throw 'No handler found for events of type ${event.runtimeType}!';
    }

    final currentState = _state.value;
    final newState = await handler.call(event, currentState);

    _state.add(newState);
    _logger.info('state updated\n$newState');
  }
}
