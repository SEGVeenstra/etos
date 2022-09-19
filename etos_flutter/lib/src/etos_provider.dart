import 'package:etos/etos.dart';
import 'package:flutter/widgets.dart';

class EtosProvider<Tstate extends Object> extends InheritedWidget {
  const EtosProvider({
    required this.etos,
    required super.child,
    super.key,
  });

  final Etos<Tstate> etos;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    if (oldWidget is! EtosProvider<Tstate>) return true;

    return oldWidget.etos != etos;
  }

  Etos<Tstate> of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<EtosProvider<Tstate>>();

    if (provider == null) {
      throw 'An EtosProvider for $Tstate has not been found!';
    }

    return provider.etos;
  }
}
