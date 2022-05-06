import 'package:flutter/material.dart';

import '../../../global_components/account_check_text.dart';
import '../../../global_components/loading.dart';
import '../../../global_components/rounded_button.dart';
import '../../../global_components/rounded_text_form_field.dart';
import '../../../services/auth_service.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    Key? key,
    required this.toggle,
  }) : super(key: key);
  final VoidCallback toggle;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: size.height * 0.15,
                        color: Colors.blueAccent,
                      ),
                      RoundedTextFormField(
                        onChanged: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Enter an email';
                          } else if (!val.contains('@')) {
                            return '@ is missing';
                          } else {
                            return null;
                          }
                        },
                        hintText: 'Email',
                        icon: const Icon(Icons.email),
                      ),
                      const SizedBox(height: 20.0),
                      RoundedTextFormField(
                        validator: (val) {
                          if (val!.length < 5) {
                            return 'Enter a password 5+ char long';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        hintText: 'Password',
                        icon: const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        error,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      RoundedButton(
                        text: 'REGISTER',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .registerWithEmailAndPassowrd(email, password);
                            if (result == 'email-already-in-use') {
                              setState(() {
                                error =
                                    "The account already exists for that email";
                                loading = false;
                              });
                            } else if (result == "weak-password") {
                              setState(() {
                                error = "The password provided is too weak";
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 20.0),
                      AccountCheckText(
                        text: 'Already have an account ? ',
                        gestureText: 'Sign in',
                        onTap: widget.toggle,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
