import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController newPasswordController = TextEditingController();
  String errorAuth = "";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: ListView(
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                Icon(
                  Icons.person,
                  color: Colors.green,
                ),
                SizedBox(width: 8),
                Text(
                  "Account",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Divider(height: 15, thickness: 2),
            const SizedBox(height: 10),
            buildAccountOptionRow(context, 'Change Password', () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        title: const Text('Set new password'),
                        content: SizedBox(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              TextField(
                                controller: newPasswordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  label: Text('New Password'),
                                  hintText: "************",
                                  prefixIcon: Icon(Icons.key),
                                ),
                                onChanged: (val) {},
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              TextButton(
                                  child: const Text('Confirm'),
                                  onPressed: () async {
                                    final result =
                                        await _auth.updatePasswordLoggedInUser(
                                            newPasswordController.text,
                                            context);
                                    setState(() {
                                      errorAuth = result;
                                    });
                                    if (result == "Successful!") {
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        errorAuth = result;
                                      });
                                    }
                                  }),
                            ],
                          )
                        ],
                      ));
            }),
            // buildAccountOptionRow(context, "Content settings"),
            // buildAccountOptionRow(context, "Social"),
            // buildAccountOptionRow(context, "Language"),
            // buildAccountOptionRow(context, "Privacy and Security"),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: const [
                // Icon(
                //   Icons.volume_up_outlined,
                //   color: Colors.green,
                // ),
                SizedBox(width: 8),
                // Text(
                //   "Notifications",
                //   style: TextStyle(
                //     fontSize: 18,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
            const Divider(height: 15, thickness: 2),
            const SizedBox(height: 10),
            // buildNotificationOptionRow("Account activity"),
            // buildNotificationOptionRow("Opportunity"),
            // buildNotificationOptionRow("New for you"),
            const SizedBox(height: 50),
            OutlinedButton(
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
              child:
                  const Text('SIGN OUT', style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(size.width * 0.70, 55),
                ),
                textStyle: MaterialStateProperty.all(
                  const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 2.2,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildNotificationOptionRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title.toString(),
          style: TextStyle(
              fontSize: 18.00,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600]),
        ),
        Transform.scale(
          scale: 0.7,
          child: CupertinoSwitch(
            value: true,
            onChanged: (bool val) {},
          ),
        ),
      ],
    );
  }

  GestureDetector buildAccountOptionRow(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                  ),
                ),
                Text(errorAuth),
                const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
