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

  static Etos<T> of<T extends Object>(BuildContext context,
      {bool listen = true}) {
    final EtosProvider<T>? provider;

    if (listen) {
      provider = context.dependOnInheritedWidgetOfExactType<EtosProvider<T>>();
    } else {
      provider = context.findAncestorWidgetOfExactType<EtosProvider<T>>();
    }

    if (provider == null) {
      throw 'An EtosProvider for $T has not been found!';
    }

    return provider.etos;
  }
}

extension EtosProviderExt on BuildContext {
  Etos<T> etos<T extends Object>() {
    return EtosProvider.of<T>(this);
  }
}
