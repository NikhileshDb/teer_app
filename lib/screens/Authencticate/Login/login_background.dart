import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({Key? key, required this.child}) : super(key: key);
  final Widget child;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Image.asset(
            "assets/images/login_bottom.png",
            width: size.width * 0.35,
          ),
          bottom: 0,
          right: 0,
        ),

        //login form as paremeter
        child,
      ],
    );
  }
}
