import 'dart:async';

import 'package:flutter/widgets.dart';

import '../etos_flutter.dart';

class EtosBuilder<T extends Object> extends StatefulWidget {
  const EtosBuilder({
    required this.builder,
    this.etos,
    super.key,
  });

  final Etos<T>? etos;
  final Widget Function(BuildContext context, T state) builder;

  @override
  State<EtosBuilder<T>> createState() => _EtosBuilderState<T>();
}

class _EtosBuilderState<T extends Object> extends State<EtosBuilder<T>> {
  late final StreamSubscription _streamSubscription;

  late Etos<T> etos;

  late T state;

  @override
  void initState() {
    super.initState();
    if (widget.etos != null) {
      etos = widget.etos!;
    } else {
      etos = EtosProvider.of<T>(context, listen: false);
    }

    state = etos.currentState;
    _streamSubscription = etos.state.listen(
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
