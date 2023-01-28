import 'dart:async';

import 'package:flutter/widgets.dart';

import '../etos_flutter.dart';

typedef EventListenerListener<T> = void Function(BuildContext context, T event);

class EventListener<Tstate extends Object> extends StatefulWidget {
  const EventListener({
    required this.child,
    required this.listener,
    this.etos,
    super.key,
  });

  final Widget child;
  final Etos<Tstate>? etos;
  final EventListenerListener<Object> listener;

  @override
  State<EventListener<Tstate>> createState() => _EventListenerState<Tstate>();
}

class _EventListenerState<Tstate extends Object>
    extends State<EventListener<Tstate>> {
  StreamSubscription? sub;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final etos = widget.etos ?? EtosProvider.of(context);
    sub?.cancel();
    sub = etos.events.listen(
      (event) => widget.listener(context, event),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }
}
