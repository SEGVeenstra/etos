import 'package:flutter/material.dart';

import '../etos_flutter.dart';

class StateBuilder<Tstate extends Object, Tvalue extends Object?>
    extends StatelessWidget {
  const StateBuilder({
    this.etos,
    required this.builder,
    required this.converter,
    this.buildWhen,
    super.key,
  });

  final Etos<Tstate>? etos;
  final Widget Function(BuildContext context, Tvalue value) builder;
  final Converter<Tstate, Tvalue> converter;
  final bool Function(Tstate state)? buildWhen;

  @override
  Widget build(BuildContext context) {
    final etosToUse = etos ?? EtosProvider.of(context) as Etos<Tstate>;

    return StreamBuilder<Tvalue>(
      stream: etosToUse.states
          .where((state) => buildWhen?.call(state) ?? true)
          .map(converter),
      initialData: converter(etosToUse.state),
      builder: (context, snapshot) => builder(
        context,
        snapshot.data as Tvalue,
      ),
    );
  }
}
