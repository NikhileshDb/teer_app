import 'package:flutter/material.dart';

import 'register_background.dart';
import 'register_form.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
    required this.toggle,
  }) : super(key: key);
  final VoidCallback toggle;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RegisterBackground(
          child: RegisterForm(toggle: toggle),
        ),
      ),
    );
  }
}
