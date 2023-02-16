import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart';

class EtosInspector<Tstate extends Object> extends StatefulWidget {
  final Widget child;
  final Etos<Tstate>? etos;

  const EtosInspector({
    super.key,
    required this.child,
    this.etos,
  });

  @override
  State<EtosInspector<Tstate>> createState() => _EtosInspectorState<Tstate>();
}

class _EtosInspectorState<Tstate extends Object>
    extends State<EtosInspector<Tstate>> {
  bool _showInspector = false;

  void _toggleInspector() {
    setState(() {
      _showInspector = !_showInspector;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          if (_showInspector)
            Positioned.fill(
              child: IgnorePointer(
                child: _InspectorOverlay<Tstate>(widget.etos),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _toggleInspector,
              child: const Text('I'),
            ),
          ),
        ],
      ),
    );
  }
}

class _InspectorOverlay<Tstate extends Object> extends StatelessWidget {
  final Etos<Tstate>? etos;

  const _InspectorOverlay(this.etos);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.black54,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: StateBuilder<Tstate, Object>(
          etos: etos,
          converter: (state) => state,
          builder: (context, value) {
            return Text(
              'Current state:\n\n$value',
              style: const TextStyle(fontSize: 16),
            );
          },
        ),
      ),
    );
  }
}
