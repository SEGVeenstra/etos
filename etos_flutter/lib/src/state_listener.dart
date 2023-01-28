import 'dart:async';

import 'package:flutter/widgets.dart';

import '../etos_flutter.dart';

typedef Listener<T> = void Function(
    BuildContext context, T? oldValue, T newValue);

class StateListener<Tstate extends Object, Tvalue extends Object?>
    extends StatefulWidget {
  const StateListener({
    required this.child,
    required this.listener,
    required this.converter,
    this.etos,
    super.key,
  });

  final Widget child;
  final Etos<Tstate>? etos;
  final Listener<Tvalue> listener;
  final Converter<Tstate, Tvalue> converter;

  @override
  State<StateListener> createState() => _StateListenerState<Tstate, Tvalue>();
}

class _StateListenerState<Tstate extends Object, Tvalue extends Object?>
    extends State<StateListener<Tstate, Tvalue>> {
  StreamSubscription<Tvalue>? sub;

  Tvalue? currentValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final etos = widget.etos ?? EtosProvider.of(context);
    sub?.cancel();
    sub = etos.states.map((state) => widget.converter(state)).listen(
      (newValue) {
        widget.listener(context, currentValue, newValue);
        currentValue = newValue;
      },
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
