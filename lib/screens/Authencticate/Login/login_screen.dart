import 'package:flutter/material.dart';
import 'login_background.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.toggle}) : super(key: key);
  final VoidCallback toggle;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Background(
          child: LoginForm(toggle: toggle),
        ),
      ),
    );
  }
}
