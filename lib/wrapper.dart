import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/screens/Authencticate/authenticate.dart';

import 'global_components/bottom_navigation.dart';
import 'models/user_model.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    if (user == null) {
      return const Authenticate();
    } else {
      return const NavigationCurved();
    }
  }
}
