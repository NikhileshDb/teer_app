import 'package:flutter/material.dart';

import '../../global_components/constants.dart';

class GestureCard extends StatelessWidget {
  const GestureCard({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        height: size.height * 0.15,
        width: size.width * 0.45,
        decoration: BoxDecoration(
            color: ksecondaryLight, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade900),
            ),
            const SizedBox(height: 10),
            Text(
              '12:03:2022',
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }
}
