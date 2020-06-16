
import 'package:auth_firebase/src/models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Future<void> updateUserData(String displayName, String photoUrl, String email, String phoneNumber) async {
    return await userCollection.document(uid).setData({
      'displayName': displayName,
      'photoUrl': photoUrl,
      'email': email,
      'phoneNumber': phoneNumber,
    });
  }

  // brew list from snapshot
  // List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.documents.map((doc){
  //     //print(doc.data);
  //     return Brew(
  //       name: doc.data['name'] ?? '',
  //       strength: doc.data['strength'] ?? 0,
  //       sugars: doc.data['sugars'] ?? '0'
  //     );
  //   }).toList();
  // }

  // user data from snapshots
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      email: snapshot.data['email'],
      displayName: snapshot.data['displayName'],
      phoneNumber: snapshot.data['phoneNumber'],
      photoUrl: snapshot.data['photoUrl']
    );
  }

  // get brews stream
  // Stream<List<Brew>> get brews {
  //   return brewCollection.snapshots()
  //     .map(_brewListFromSnapshot);
  // }

  // get user doc stream
  Stream<User> get userData {
    return userCollection.document(uid).snapshots()
      .map(_userDataFromSnapshot);
  }

}