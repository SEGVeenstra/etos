import 'package:flutter/material.dart';

import '../etos_flutter.dart';

class EtosBuilder<Tstate extends Object, Tvalue extends Object>
    extends StatelessWidget {
  const EtosBuilder({
    this.etos,
    required this.builder,
    required this.converter,
    super.key,
  });

  final Etos<Tstate>? etos;
  final Widget Function(BuildContext context, Tvalue value) builder;
  final Tvalue Function(Tstate state) converter;

  @override
  Widget build(BuildContext context) {
    final etosToUse = etos ?? EtosProvider.of<Tstate>(context);

    return StreamBuilder<Tvalue>(
      stream: etosToUse.stream.map(converter),
      initialData: converter(etosToUse.state),
      builder: (context, snapshot) => builder(
        context,
        snapshot.data!,
      ),
    );
  }
}
