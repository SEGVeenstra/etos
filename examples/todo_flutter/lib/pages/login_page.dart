import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_flutter/events/login_event.dart';
import 'package:todo_flutter/main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: Center(
        child: ElevatedButton(
          onPressed: _onPressed,
          child: const Text('Login'),
        ),
      ),
    );
  }

  void _onPressed() {
    etos.dispatch(LoginEvent('Stephan'));
  }
}
