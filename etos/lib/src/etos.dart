import 'dart:async';

import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

final _logger = Logger('Etos');

const _notLinkedError = 'EventHandler not linked to Etos.'
    'Are you trying to call it yourself?'
    'EnentHandlers should only be called by Etos, please add this EventHandler to an Etos by using the Etos.on<Event>(EventHandler) method.';

abstract class EventHandler<Tstate extends Object, Tevent> {
  Etos<Tstate>? _etos;

  EventHandler();

  void _init(Etos<Tstate> etos) {
    _etos = etos;
  }

  Tstate getState() {
    assert(_etos != null, _notLinkedError);
    return _etos!.state;
  }

  void setState(Tstate state) {
    assert(_etos != null, _notLinkedError);
    _etos!._setState(state);
  }

  void dispatch(Object event) {
    assert(_etos != null, _notLinkedError);
    _etos!.dispatch(event);
  }

  /// Decide if this EventHandler can be called based on the current state.
  ///
  /// Return true if you want this EventHandler to be called, else false.
  bool callWhen(Tstate state) => true;

  FutureOr<void> call(Tevent event);
}

class Etos<Tstate extends Object> {
  final _eventHandlers = <Type, EventHandler<Tstate, Object>>{};
  final _statesController = BehaviorSubject<Tstate>();
  final _eventsController = StreamController<Object>();

  late final Stream<Tstate> _statesStream;
  late final Stream<Object> _eventsStream;

  /// A stream with the states
  ///
  /// On listening will give you the current state
  Stream<Tstate> get states => _statesStream;
  Stream<Object> get events => _eventsStream;

  Tstate get state => _statesController.value;

  Etos({required Tstate state}) {
    _statesStream = _statesController.stream.asBroadcastStream();
    _eventsStream = _eventsController.stream.asBroadcastStream();

    _logger.info('Creeated with initial state:\n$state');
    _statesController.add(state);
  }

  void on<Tevent extends Object>(EventHandler<Tstate, Tevent> handler) {
    if (_eventHandlers[Tevent] != null) {
      _logger.warning('Tried adding an EventHandler for $Tevent,'
          '\nbut an EventListener has already been registered for $Tevent');
      return;
    }

    handler._init(this);

    _eventHandlers[Tevent] = handler;
    _logger.info('Eventhandler added for $Tevent');
  }

  void dispatch(Object event) async {
    _logger.info('dispatched event\n$event');
    _eventsController.add(event);

    final handler = _eventHandlers[event.runtimeType];

    if (handler == null) {
      _logger.info('No handler found for events of type ${event.runtimeType}!');
      return;
    } else if (!handler.callWhen(state)) {
      _logger.info('Handler does not meet it\'s condition to run!');
      return;
    }

    await handler.call(event);
  }

  void _setState(newState) {
    _statesController.add(newState);
    _logger.info('state updated\n$newState');
  }
}
