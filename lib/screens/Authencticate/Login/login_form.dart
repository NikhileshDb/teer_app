import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../global_components/account_check_text.dart';
import '../../../global_components/loading.dart';
import '../../../global_components/rounded_button.dart';
import '../../../global_components/rounded_text_form_field.dart';
import '../../../services/auth_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
    required this.toggle,
  }) : super(key: key);
  final VoidCallback toggle;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? const Loading()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Sign In',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black38),
                  ),
                  SvgPicture.asset("assets/svg/login.svg",
                      height: size.height * 0.25),
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
                    hintText: "Email",
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
                    onChanged: (val) => password = val,
                    hintText: "Password",
                    obscureText: true,
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
                    text: 'Submit',
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            email, password);
                        if (result == 'user-not-found') {
                          setState(() {
                            error = "No user was found for that email.";
                            loading = false;
                          });
                        } else if (result == 'wrong-password') {
                          setState(() {
                            error = 'Wrong password!';
                            loading = false;
                          });
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 10.0),
                  AccountCheckText(
                    text: 'Didn\'t have an account ? ',
                    gestureText: 'Sign up',
                    onTap: widget.toggle,
                  ),
                ],
              ),
            ),
          );
  }
}
