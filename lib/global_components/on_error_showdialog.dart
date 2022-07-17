import 'package:flutter/material.dart';

Future<dynamic> onErrorShowDialog(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return showDialog(
      context: context,
      builder: (context) => Dialog(
            child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.blue,
                height: size.height * 0.25,
                width: size.width * 0.03,
                child: Column(
                  children: const [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 100,
                      color: Colors.red,
                    ),
                    Text(
                      'Sorry the requested resource is not available right now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                )),
          ));
}
