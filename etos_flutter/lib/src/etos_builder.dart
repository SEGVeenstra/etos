import 'dart:async';

import 'package:etos/etos.dart';
import 'package:flutter/widgets.dart';

class EtosBuilder<T extends Object> extends StatefulWidget {
  const EtosBuilder({
    required this.builder,
    required this.etos,
    super.key,
  });

  final Etos<T> etos;
  final Widget Function(BuildContext context, T state) builder;

  @override
  State<EtosBuilder<T>> createState() => _EtosBuilderState<T>();
}

class _EtosBuilderState<T extends Object> extends State<EtosBuilder<T>> {
  late final StreamSubscription _streamSubscription;

  late T state;

  @override
  void initState() {
    super.initState();
    state = widget.etos.currentState;
    _streamSubscription = widget.etos.state.listen(
      (event) => setState(
        () => state = event,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(
      context,
      state,
    );
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
  }
}
