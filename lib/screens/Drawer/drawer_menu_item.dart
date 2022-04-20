import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          Icon(icon, color: Colors.orange, size: 25),
          const SizedBox(width: 10),
          Text(title,
              style: TextStyle(
                  color: Colors.grey.shade500, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
