import 'package:flutter/material.dart';
import 'package:teer_common/global_components/constants.dart';

import 'drawer_menu_item.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kprimaryLight,
      padding: const EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static.toiimg.com/thumb/msid-83924974,width-1200,height-900,resizemode-4/.jpg'),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nikhilesh Debbarma',
                    style: TextStyle(
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text('online', style: TextStyle(color: Colors.blue))
                ],
              ),
            ],
          ),
          Column(
            children: const [
              DrawerMenuItem(icon: Icons.location_on, title: 'Shillong Result'),
              DrawerMenuItem(
                  icon: Icons.location_city, title: 'Khanapara Result'),
              DrawerMenuItem(icon: Icons.track_changes, title: 'Common Number'),
              DrawerMenuItem(icon: Icons.wb_cloudy, title: 'Dream Number'),
              DrawerMenuItem(
                  icon: Icons.multiple_stop, title: 'Previous Number'),
              DrawerMenuItem(icon: Icons.notifications, title: 'Notification'),
            ],
          ),
          Row(
            children: [
              const Icon(
                Icons.settings,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.black,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Log out',
                style: TextStyle(
                    color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              )
            ],
          )
        ],
      ),
    );
  }
}
