import 'package:flutter/material.dart';

class DrawerMenuItem extends StatelessWidget {
  const DrawerMenuItem({
    Key? key,
    required this.title,
    required this.icon,
    required this.onTap,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
      ),
    );
  }
}
