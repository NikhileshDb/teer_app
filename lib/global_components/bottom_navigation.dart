import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:teer_common/screens/Common/common_number.dart';

import '../screens/Drawer/drawer_wrapper.dart';
import '../screens/History/result_history.dart';

import 'constants.dart';

class NavigationCurved extends StatefulWidget {
  const NavigationCurved({Key? key}) : super(key: key);

  @override
  State<NavigationCurved> createState() => _NavigationCurvedState();
}

class _NavigationCurvedState extends State<NavigationCurved> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  final screens = [
    const DrawerWrapper(),
    const HistoryScreen(),
    const CommonNumber(),
  ];
  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(
        Icons.home,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.history,
        size: 30,
        color: Colors.white,
      ),
      const Icon(
        Icons.comment_bank,
        size: 30,
        color: Colors.white,
      ),
    ];
    return Container(
      color: Colors.white,
      child: SafeArea(
        top: false,
        child: ClipRect(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.black,
            body: IndexedStack(
              index: index,
              children: screens,
            ),
            bottomNavigationBar: CurvedNavigationBar(
              key: navigationKey,
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: kprimaryLight,
              color: Colors.black,
              height: 50,
              index: index,
              items: items,
              onTap: (index) => setState(() => this.index = index),
            ),
          ),
        ),
      ),
    );
  }
}
