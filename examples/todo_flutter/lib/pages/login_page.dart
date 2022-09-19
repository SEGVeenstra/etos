import 'package:flutter/material.dart';
import 'package:todo_flutter/events/login_event.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: Center(
        child: ElevatedButton(
          key: const ValueKey('login_button'),
          onPressed: () => _onPressed(context),
          child: const Text('Login'),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    etos.dispatch(const LoginEvent('Stephan'));
  }
}
