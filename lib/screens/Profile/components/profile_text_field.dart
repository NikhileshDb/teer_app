import 'package:flutter/material.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.isPasswordField,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  final String label;
  final String? hintText;
  final bool isPasswordField;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: widget.controller,
        onChanged: widget.onChanged,
        obscureText: widget.isPasswordField ? showPassword : false,
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: const Icon(Icons.remove_red_eye),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          label: Text(widget.label),
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
