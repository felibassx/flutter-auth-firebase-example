import 'package:auth_firebase/src/models/UserModel.dart';
import 'package:auth_firebase/src/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? User(
            uid: user.uid,
            displayName: user.displayName,
            photoUrl: user.photoUrl,
            email: user.email,
            phoneNumber: user.phoneNumber
          )
        : null;
  }

  // auth change user stream
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future<User> signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String password, String displayName, String photoUrl, String email, String phoneNumber) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(displayName, photoUrl, email, phoneNumber);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  // Future registerWithGoogle(String email) async {
  //   try {
  //     AuthResult result = await _auth.signInWithCredential(credential)
  //     FirebaseUser user = result.user;
  //     // create a new document for the user with the uid
  //     await DatabaseService(uid: user.uid).updateUserData(email, name);
  //     return _userFromFirebaseUser(user);
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }

  // sign out
  Future signOut() async {
    try {
      await _auth.signOut();
      return  true;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // forgot password
  Future<bool> passwordRestoreWhitEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
