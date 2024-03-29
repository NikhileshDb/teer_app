import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[100],
      child: const Center(
          child: SpinKitChasingDots(
        color: Color.fromARGB(255, 255, 107, 28),
        size: 50.0,
      )),
    );
  }
}
