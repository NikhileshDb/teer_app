import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/profile_details.dart';
import '../../models/teer_result.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  //collection reference
  final CollectionReference userProfile =
      FirebaseFirestore.instance.collection('profiles');

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

  //latest result collection reference
  final CollectionReference latestResult =
      FirebaseFirestore.instance.collection('results');

  //filtering  and querying the results stream

  Future addLatestResult(
      {String? firstRound,
      String? secondRound,
      required DateTime date,
      required String provider}) async {
    return await latestResult.add(
      {
        "firstRound": firstRound,
        'secondRound': secondRound,
        'date': date,
        'provider': provider,
      },
    );
  }

  //get the list of teer results from snapshot
  List<TeerResult> _resultListFromSnapShot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TeerResult(
        date: doc.get('date').toDate(),
        provider: doc.get('provider'),
        firstRound: int.parse(doc.get('firstRound')),
        secondRound: int.parse(doc.get('secondRound')),
      );
    }).toList();
  }

  //get Teer result streams
  Stream<List<TeerResult>> get results {
    return latestResult.snapshots().map(_resultListFromSnapShot);
  }

  //get the list of results filtering by provider
  Future<List<TeerResult>> filterTeer(
      String provider, DateTime? startDate, DateTime? endDate) async {
    QuerySnapshot result = await latestResult
        .where('provider', isEqualTo: provider)
        .where('date',
            isGreaterThan:
                endDate ?? DateTime.now().subtract(const Duration(days: 30)))
        .where('date', isLessThan: startDate ?? DateTime.now())
        .get();
    return result.docs.map((doc) {
      return TeerResult(
        date: doc.get('date').toDate(),
        provider: doc.get('provider'),
        firstRound: int.parse(doc.get('firstRound')),
        secondRound: int.parse(doc.get('secondRound')),
      );
    }).toList();
  }
  //
}
