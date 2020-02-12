import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tassist/core/models/user.dart';

class AuthService {
  static var _authCredential, actualCode;

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

      Firestore.instance
          .collection('metrics')
          .document(user.uid)
          .setData({'total_sales': 0});

      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future verifyPhone(String phone) async {
    print(phone.toString());
    _auth
        .verifyPhoneNumber(
            phoneNumber: phone.toString(),
            timeout: Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      print('Code sent');
    }).catchError((error) {
      print(error.toString());
    });
  }

  void codeSent(String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    print("\nEnter the code sent");
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    actualCode = verificationId;
    print("\nAuto retrieval time out");
  }

  void verificationFailed(AuthException authException) {
    print('${authException.message}');
    if (authException.message.contains('not authorized'))
      print('App not authroized');
    else if (authException.message.contains('Network'))
      print('Please check your internet connection and try again');
    else
      print('Something has gone wrong, please try later ' +
          authException.message);
  }

  void verificationCompleted(AuthCredential auth) {
    print('Auto retrieving verification code');

    _auth.signInWithCredential(auth).then((AuthResult result) {
      if (result.user != null) {
        print('Authentication successful');
        // onAuthenticationSuccessful();
      } else {
        print('Invalid code/invalid authentication');
      }
    }).catchError((error) {
      print('Something has gone wrong, please try later $error');
    });
  }

  Future signInWithPhone({String smsCode}) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    _auth.signInWithCredential(_authCredential).then((AuthResult result) async {
      print('Authentication successful');
      // onAuthenticationSuccessful();
    }).catchError((error) {
      print(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
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
