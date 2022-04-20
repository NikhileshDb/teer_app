import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:teer_common/screens/Settings/settings_screen.dart';

import '../../models/profile_details.dart';
import '../../models/user_model.dart';
import '../../services/database/database_service.dart';
import 'components/profile_body.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    return StreamProvider<ProfileDetails?>.value(
      value: DatabaseService(uid: user!.uid).profiles,
      initialData: null,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SettingsScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.settings, color: Colors.green),
            ),
          ],
        ),
        body: const ProfileBody(),
      ),
    );
  }
}
