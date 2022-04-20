import 'package:flutter/material.dart';

class RoundedTextFormField extends StatelessWidget {
  const RoundedTextFormField({
    Key? key,
    this.hintText,
    this.obscureText,
    this.onChanged,
    this.controller,
    this.icon,
    this.validator,
  }) : super(key: key);
  final String? hintText;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  final Icon? icon;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      obscureText: obscureText == null ? false : true,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        hintText: hintText,
        prefixIcon: icon,
      ),
    );
  }
}
