import 'package:flutter/material.dart';
import 'package:teer_common/screens/Common/common_screen.dart';
import 'package:teer_common/screens/Settings/settings_screen.dart';
import 'package:teer_common/wrapper.dart';

import '../global_components/navigation_error_screen.dart';
import '../screens/History/result_history.dart';
import '../screens/Home/home_screen.dart';
import '../screens/Profile/profile_screen.dart';

class AppRoute {
  Route<String>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        {
          return MaterialPageRoute(builder: (context) => const Wrapper());
        }
      case '/home':
        {
          return MaterialPageRoute(builder: (context) => const HomeScreen());
        }
      case '/common_number':
        {
          return MaterialPageRoute(
              builder: (context) => const CommoNumberScreen());
        }
      case '/history':
        {
          return MaterialPageRoute(
            builder: (context) => const HistoryScreen(),
          );
        }
      case '/settings':
        {
          return MaterialPageRoute(
              builder: (context) => const SettingsScreen());
        }
      case '/profile':
        {
          return MaterialPageRoute(builder: (context) => const ProfileScreen());
        }
      default:
        return MaterialPageRoute(builder: (context) => const NavigationError());
    }
  }
}
