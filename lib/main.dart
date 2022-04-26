import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/screens/Home/home_screen.dart';
import 'package:teer_common/services/auth_service.dart';

import 'package:teer_common/wrapper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'models/user_model.dart';
import 'screens/Common/common_screen.dart';
import 'screens/Settings/settings_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      builder: (context, snapshot) {
        return MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
            '/home': (context) => const HomeScreen(),
            '/common_number': (context) => const CommoNumberScreen(),
            '/settings': (context) => const SettingsScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: 'Common Number',
          theme: ThemeData(fontFamily: 'Montserrat'),
        );
      },
    );
  }
}
