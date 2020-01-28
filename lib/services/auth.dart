import 'package:firebase_auth/firebase_auth.dart';
import 'package:tassist/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // convert firebase user into custom User instance
  _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<FirebaseUser> get user {
    return _auth.onAuthStateChanged;
    // .map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // return _userFromFirebaseUser(user);
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }
}

// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tassist/database.dart';

// abstract class BaseAuth {
//   Future<String> signIn(String email, String password);
//   Future<String> signUp(String email, String password);
//   Future<FirebaseUser> getCurrentUser();
//   Future<void> signOut();
// }

// class Auth implements BaseAuth {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   Future<String> signIn(String email, String password) async {
//     // FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;
//     return user.uid;
//   }
//   Future<String> signUp(String email, String password) async {
//     AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//     FirebaseUser user = result.user;
//     var userId = user.uid;

//     // create a new metric document when a user signs up
//     await DatabaseService( uid: userId ).createMetricsRecord();

//     return userId;
//   }
//   Future<FirebaseUser> getCurrentUser() async {
//     FirebaseUser user = await _firebaseAuth.currentUser();
//     return user;
//   }
//   Future<void> signOut() async {
//     return _firebaseAuth.signOut();
//   }
// }
