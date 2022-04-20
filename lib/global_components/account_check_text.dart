import 'package:flutter/material.dart';

class AccountCheckText extends StatelessWidget {
  const AccountCheckText({
    required this.text,
    required this.gestureText,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String text;
  final String gestureText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text),
        GestureDetector(
          onTap: onTap,
          child: Text(
            gestureText,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
