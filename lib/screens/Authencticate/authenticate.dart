import 'package:flutter/material.dart';

import 'Login/login_screen.dart';
import 'Regsiter/register_screen.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;
  void toggleView() {
    setState(() => showLogin = !showLogin);
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginScreen(
        toggle: toggleView,
      );
    } else {
      return RegisterScreen(
        toggle: toggleView,
      );
    }
  }
}
