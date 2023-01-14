import 'package:etos/etos.dart';
import 'package:flutter/widgets.dart';

class EtosProvider<Tstate extends Object> extends StatelessWidget {
  const EtosProvider({
    required this.child,
    required this.etos,
    super.key,
  });

  final Etos<Tstate> etos;
  final Widget child;

  static Etos<T> of<T extends Object>(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<_InheritedEtos>();
    if (provider == null) throw 'Provider not found for type!';

    return provider.etos as Etos<T>;
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedEtos(etos: etos, child: child);
  }
}

class _InheritedEtos extends InheritedWidget {
  const _InheritedEtos({
    required this.etos,
    required super.child,
  });

  final Etos etos;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

extension EtosExt on BuildContext {
  void dispatch(Object event) => EtosProvider.of(this).dispatch(event);
  Etos<T> of<T extends Object>() => EtosProvider.of<T>(this);
}
