import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:teer_common/global_components/rounded_button.dart';

import '../../../global_components/bottom_navigation.dart';

import '../authenticate.dart';

enum MobileVerificationState { showMobileFormState, showOtpFormState }

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  MobileVerificationState currentState =
      MobileVerificationState.showMobileFormState;
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool showLoading = false;
  String verificationIdfromFirebase = "";

// verify phonenumber and handle the phone auth

  Future verifyPhonenumber(String phoneNumber, BuildContext context) async {
    String phone = "+91" + phoneNumber.toString();
    await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: const Duration(seconds: 5),
        verificationCompleted: (authCredential) =>
            _verificationCompleted(authCredential, context),
        verificationFailed: (authException) =>
            _verificationFailed(authException, context),
        codeSent: (verificationId, [code]) =>
            _smsCodeSent(verificationId, [code], context),
        codeAutoRetrievalTimeout: (verificationId) =>
            _codeAutoRetrievalTimeout(verificationId));
  }

//phoneAuth Verification Complete
  _verificationCompleted(AuthCredential authCredential, BuildContext context) {
    setState(() {
      showLoading = false;
    });
    _auth.signInWithCredential(authCredential).then((authResult) {
      const snackBar = SnackBar(content: Text('Success!!!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  //phoneAuth verification verificationFailed Exception
  _verificationFailed(
      FirebaseAuthException authException, BuildContext context) {
    setState(() {
      showLoading = false;
    });
    final snackBar = SnackBar(content: Text(authException.message.toString()));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //phone verification code
  _smsCodeSent(String verificationId, List<int?> code, BuildContext context) {
    setState(() {
      showLoading = false;
      currentState = MobileVerificationState.showOtpFormState;
      verificationIdfromFirebase = verificationId;
    });
  }

  _codeAutoRetrievalTimeout(String verificationId) {
    // set the verification code so that we can use it to log the user in
    verificationIdfromFirebase = verificationId;
  }

  void signInWithAuthCredential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      showLoading = true;
    });
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        showLoading = false;
      });

      if (authCredential.user != null) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const NavigationCurved()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        showLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo.png", height: size.height * 0.25),
            //get the form depending on the state of the firebase phone auth
            showLoading
                ? CircularProgressIndicator(color: Colors.blueAccent[100])
                : currentState == MobileVerificationState.showMobileFormState
                    ? getMobileForm()
                    : getOTPForm(),
            const SizedBox(height: 20),
            const Text('Or'),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Authenticate()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Sing in using email',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 5),
                    Icon(Icons.email),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Column getOTPForm() {
    return Column(
      children: [
        TextField(
          controller: otpController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: "OTP",
            hintStyle: TextStyle(color: Colors.grey.shade700),
            prefixIcon: const Icon(Icons.message),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onChanged: (val) {},
        ),
        const SizedBox(height: 20),
        RoundedButton(
          text: 'Verify OTP',
          onPressed: () async {
            PhoneAuthCredential phoneAuthCredential =
                PhoneAuthProvider.credential(
                    verificationId: verificationIdfromFirebase,
                    smsCode: otpController.text);
            signInWithAuthCredential(phoneAuthCredential);
          },
        ),
      ],
    );
  }

  Column getMobileForm() {
    return Column(
      children: [
        TextField(
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            prefixText: '+91',
            hintText: " Phone number",
            hintStyle: TextStyle(color: Colors.grey.shade700),
            prefixIcon: const Icon(Icons.phone),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          onChanged: (val) {},
        ),
        const SizedBox(height: 20),
        RoundedButton(
          text: 'Send code',
          onPressed: () {
            setState(() {
              showLoading = true;
            });
            verifyPhonenumber(phoneNumberController.text, context);
          },
        ),
      ],
    );
  }
}
