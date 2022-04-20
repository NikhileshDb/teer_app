class ProfileDetails {
  String? displayName;
  String? email;
  String? photoURL;
  int? phoneNumber;
  ProfileDetails(
      {this.displayName, this.photoURL, this.phoneNumber, this.email});

  ProfileDetails.fromMap(Map<String, dynamic> data)
      : displayName = data["displayName"],
        photoURL = data["photoURL"],
        email = data["email"],
        phoneNumber = data["phoneNumber"];

  Map<String, dynamic> toMap() => {
        "displayName": displayName,
        "photoURL": photoURL,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
