import 'package:logging/logging.dart';
import 'package:rxdart/subjects.dart';

final _logger = Logger('Etos');

typedef EtosHandler<Tstate extends Object> = Tstate Function(
    Object event, Tstate state);

class Etos<Tstate extends Object> {
  final _eventHandlers = <Type, EtosHandler<Tstate>>{};
  final _state = BehaviorSubject<Tstate>();

  Stream<Tstate> get state => _state.stream;

  Etos({required Tstate state}) {
    _logger.info('Creeated with initial state:\n$state');
    _state.add(state);
  }

  void on<Tevent extends Object>(EtosHandler<Tstate> handler) {
    if (_eventHandlers[Tevent] != null) {
      _logger.warning('Tried adding an EventHandler for $Tevent,'
          '\nbut an EventListener has already been registered for $Tevent');
      return;
    }

    _eventHandlers[Tevent] = handler;
    _logger.info('Eventhandler added for $Tevent');
  }

  void dispatch(Object event) {
    _logger.info('dispatched event\n$event');

    final handler = _eventHandlers[event.runtimeType];

    if (handler == null) {
      throw 'No handler found for events of type ${event.runtimeType}!';
    }

    final currentState = _state.value;
    final newState = handler.call(event, currentState);

    _state.add(newState);
    _logger.info('state updated\n$newState');
  }
}
