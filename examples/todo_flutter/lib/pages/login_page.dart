import 'package:etos_flutter/etos_flutter.dart';
import 'package:flutter/material.dart';
import 'package:todo_flutter/events/login_event.dart';
import 'package:todo_flutter/events/logout_event.dart';
import 'package:todo_flutter/state/user_state.dart';

import '../main.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('LoginPage')),
      body: Center(
        child: EtosBuilder(
            etos: etos,
            builder: (context, state) {
              if (state.userState is LoggingIn) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    TextButton(
                        onPressed: () => etos.dispatch(LogoutEvent()),
                        child: const Text('Cancel logout')),
                  ],
                );
              }
              return ElevatedButton(
                key: const ValueKey('login_button'),
                onPressed: () => _onPressed(context),
                child: const Text('Login'),
              );
            }),
      ),
    );
  }

  void _onPressed(BuildContext context) {
    etos.dispatch(const LoginEvent('Stephan'));
  }
}
