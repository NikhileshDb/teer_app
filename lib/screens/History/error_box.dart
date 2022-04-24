import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({Key? key, required this.errorMessage}) : super(key: key);
  final String errorMessage;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errorMessage.toString()));
  }
}
