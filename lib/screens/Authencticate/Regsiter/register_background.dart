import 'package:flutter/material.dart';

class RegisterBackground extends StatelessWidget {
  const RegisterBackground({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
      ],
    );
  }
}
