import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:teer_common/models/user_model.dart';
import 'package:teer_common/wrapper.dart';

import 'database/database_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //get the user from firebase though our usermodel
  UserModel? userFromFirebase(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  //Sign in anonnymously in firebase
  Future<UserModel?>? signInAnon() async {
    try {
      UserCredential? result = await _auth.signInAnonymously();
      User? user = result.user;
      return userFromFirebase(user);
    } catch (e) {
      return null;
    }
  }

//Listening to auth status changes
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(userFromFirebase);
  }

//Signout user
  void signOut(context) async {
    await _auth.signOut().then((value) => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const Wrapper()),
        (route) => false));
  }

//register with email and password
  Future registerWithEmailAndPassowrd(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      await DatabaseService(uid: user!.uid).updateProfileData(
          'Your FullName', 'assets/images/avatar.jpg', 9856369623, email);
      return userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  //Sign in using with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      return userFromFirebase(user);
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  //loged in user update Password
  Future updatePasswordLoggedInUser(
      String? newPassword, BuildContext context) async {
    if (newPassword != null) {
      try {
        await _auth.currentUser?.updatePassword(newPassword).then(
              (_) => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password has been changed successfully!'),
                ),
              ),
            );
        return 'Successful!';
      } catch (e) {
        return "Unsucessful!";
      }
    }
  }
}
