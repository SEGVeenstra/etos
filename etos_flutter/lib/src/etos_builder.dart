import 'dart:async';

import 'package:flutter/widgets.dart';

import '../etos_flutter.dart';

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

    state = widget.etos.state;
    _streamSubscription = widget.etos.stream.listen(
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
