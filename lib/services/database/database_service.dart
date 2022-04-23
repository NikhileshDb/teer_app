import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Data/data_2022.dart';
import '../../models/profile_details.dart';
import '../../models/teer_result.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('profiles');
  //latest result collection reference
  final CollectionReference latestResult =
      FirebaseFirestore.instance.collection('results');

//setProfileData
  Future updateProfileData(String? displayName, String? photoURL,
      int? phoneNumber, String? email) async {
    return await userProfile.doc(uid).set({
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'email': email,
    });
  }

//updateUserData
  Future updateUserDetails(
      {String? displayName,
      String? photoURL,
      String? email,
      int? phoneNumber}) async {
    return await userProfile.doc(uid).update({
      'displayName': displayName,
      'photoURL': photoURL,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  //ProfileDetails Stream
  Stream<ProfileDetails?> get profiles {
    final snapshot = userProfile.doc(uid).snapshots();
    return snapshot.map((doc) {
      return ProfileDetails(
        displayName: doc['displayName'],
        email: doc['email'],
        photoURL: doc['photoURL'],
        phoneNumber: doc['phoneNumber'],
      );
    });
  }

  //import docs
  void addDoc() {
    final results = data_2022.map((doc) => TeerResult(
        date: DateTime.parse(doc['date']),
        provider: doc['provider'],
        firstRound: int.parse(doc['firstRound']),
        secondRound: int.parse(doc['secondRound'])));
    for (TeerResult result in results) {
      latestResult.add(result.toMap()).then((value) => print(value));
    }
  }

  //get the list of teer results from snapshot
  List<TeerResult> _resultListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TeerResult(
        date: doc.get('date').toDate(),
        provider: doc.get('provider'),
        firstRound: doc.get('firstRound'),
        secondRound: doc.get('secondRound'),
      );
    }).toList();
  }

  //get Teer result streams
  Stream<List<TeerResult>> get results {
    return latestResult
        .limit(10)
        .orderBy('date', descending: true)
        .snapshots()
        .map(_resultListFromSnapShot);
  }

  //get the list of results filtering by provider
  Future<List<TeerResult>> filterTeer(
      String provider, DateTime? startDate, DateTime? endDate) async {
    QuerySnapshot result = await latestResult
        .where('provider', isEqualTo: provider)
        .orderBy('date', descending: true)
        .where('date',
            isGreaterThan:
                startDate ?? DateTime.now().subtract(const Duration(days: 30)))
        .where('date', isLessThan: endDate ?? DateTime.now())
        .get();
    return result.docs.map((doc) {
      return TeerResult(
        date: doc.get('date').toDate(),
        provider: doc.get('provider'),
        firstRound: doc.get('firstRound'),
        secondRound: doc.get('secondRound'),
      );
    }).toList();
  }
  //
}
