import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/profile_details.dart';
import '../../../models/user_model.dart';
import '../../../services/database/database_service.dart';
import 'profile_text_field.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileData = Provider.of<ProfileDetails?>(context);
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;

    String? fullName = "";
    String? email = "";
    int? phone;
    final _user = Provider.of<UserModel?>(context);
    final _database = DatabaseService(uid: _user?.uid);

    return Form(
      key: _formKey,
      child: Container(
          padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
          child: ListView(
            children: <Widget>[
              const Text(
                "Edit Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10),
                          ),
                        ],
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage("assets/images/avatar.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 35),
              ProfileTextField(
                  onChanged: (val) {
                    if (val.isEmpty == true) {
                      email = profileData!.displayName;
                    } else {
                      fullName = val;
                    }
                  },
                  isPasswordField: false,
                  label: "Full Name",
                  hintText: profileData?.displayName),
              ProfileTextField(
                  onChanged: (val) {
                    if (val.isEmpty == true) {
                      email = profileData?.email;
                    } else {
                      email = val;
                    }
                  },
                  isPasswordField: false,
                  label: "Email",
                  hintText: profileData?.email),
              ProfileTextField(
                  onChanged: (val) {
                    phone = int.parse(val);
                  },
                  isPasswordField: false,
                  label: "Phone Number",
                  hintText: profileData?.phoneNumber.toString()),
              ProfileTextField(
                  onChanged: (val) {},
                  isPasswordField: true,
                  label: "Password",
                  hintText: "********"),
              const SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(size.width * 0.45, 50)),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 50),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'CANCEL',
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //*updating the userdetails
                      //?exceptions are not handled yet
                      _database.updateUserDetails(
                          displayName: fullName!.isEmpty
                              ? profileData?.displayName
                              : fullName,
                          photoURL: "https:this.is.example.com",
                          phoneNumber:
                              phone!.isNaN ? profileData?.phoneNumber : phone,
                          email: email!.isEmpty ? profileData!.email : email);
                    },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                          Size(size.width * 0.45, 50)),
                      backgroundColor: MaterialStateProperty.all(Colors.green),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(horizontal: 50),
                      ),
                      elevation: MaterialStateProperty.all(2),
                    ),
                    child: const Text(
                      'SAVE',
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
