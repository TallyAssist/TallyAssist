import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tassist/database.dart';


abstract class BaseAuth {
  Future<String> signIn(String email, String password);
  Future<String> signUp(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> signOut();
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String> signIn(String email, String password) async {
    // FirebaseUser user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    AuthResult result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    return user.uid;
  }
  Future<String> signUp(String email, String password) async {
    AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    var userId = user.uid;    

    // create a new metric document when a user signs up
    await DatabaseService( uid: userId ).createMetricsRecord(); 

    return userId;
  }
  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }
  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }
}