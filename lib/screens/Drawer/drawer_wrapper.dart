import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/screens/Drawer/drawer_screen.dart';
import 'package:teer_common/services/database/database_service.dart';

import '../../models/teer_result.dart';
import '../Home/home_screen.dart';

class DrawerWrapper extends StatefulWidget {
  const DrawerWrapper({Key? key}) : super(key: key);

  @override
  State<DrawerWrapper> createState() => _DrawerWrapperState();
}

class _DrawerWrapperState extends State<DrawerWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<TeerResult>>.value(
      value: DatabaseService().results,
      initialData: const [],
      child: Scaffold(
        body: Stack(
          children: const [
            DrawerScreen(),
            HomeScreen(),
          ],
        ),
      ),
    );
  }
}
