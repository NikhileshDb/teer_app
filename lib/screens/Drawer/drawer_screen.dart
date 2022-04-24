import 'package:flutter/material.dart';

import 'package:teer_common/global_components/constants.dart';

import '../../services/auth_service.dart';

import '../History/result_history.dart';

import 'drawer_menu_item.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final AuthService _auth = AuthService();
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
            children: [
              DrawerMenuItem(
                icon: Icons.location_on,
                title: 'Shillong Result',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryScreen(
                                gameProvider: "Shillong Teer",
                              )));
                },
              ),
              DrawerMenuItem(
                icon: Icons.location_city,
                title: 'Khanapara Result',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryScreen(
                                gameProvider: "Khanapara",
                              )));
                },
              ),
              DrawerMenuItem(
                icon: Icons.track_changes,
                title: 'Common Number',
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => const CommonNumber(),
                  //   ),
                  // );
                },
              ),
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
              // TextButton(
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => const SettingsScreen()));
              //   },
              //   child: Text(
              //     'Settings',
              //     style: TextStyle(
              //         color: Colors.grey.shade700, fontWeight: FontWeight.bold),
              //   ),
              // ),
              const SizedBox(
                width: 10,
              ),
              // Container(
              //   width: 2,
              //   height: 20,
              //   color: Colors.black,
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Sign out'),
                      content: const Text('Are you sure you want to sign out?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('No'),
                        ),
                        TextButton(
                          onPressed: () {
                            _auth.signOut(context);
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'Log out',
                  style: TextStyle(
                      color: Colors.grey.shade700, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
