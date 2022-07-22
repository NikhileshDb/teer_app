import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/routes/app_routes.dart';
import 'package:teer_common/services/auth_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'models/teer_result.dart';
import 'models/user_model.dart';
import 'services/database/database_service.dart';
import 'wrapper.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp(
    appRouter: AppRoute(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRoute appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<InitializationStatus> initGoogleMobileAds() {
    return MobileAds.instance.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
            value: AuthService().user, initialData: null),
        StreamProvider<List<TeerResult>>.value(
            value: DatabaseService().results, initialData: const []),
      ],
      builder: (context, snapshot) {
        return MaterialApp(
          onGenerateRoute: widget.appRouter.onGenerateRoute,
          debugShowCheckedModeBanner: false,
          title: 'Common Number',
          theme: ThemeData(fontFamily: 'Montserrat'),
          home: const Wrapper(),
        );
      },
    );
  }
}
