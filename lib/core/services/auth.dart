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

      // Firestore.instance
      //     .collection('metrics')
      //     .document(user.uid)
      //     .setData({'total_sales': 0});

      // Company
      Firestore.instance.collection('company').document(user.uid).setData({
        'email': user.email,
      });

      // Stock
      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('stockitem')
          .document('1')
          .setData({
        'name': 'Gur',
        'master_id': '1',
        'closingbalance': 100,
        'closingvalue': 25000,
        'baseunits': 'kg',
        'closingrate': 250,
        'standardcost': 225,
        'standardprice': 240,
      });
      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('stockitem')
          .document('2')
          .setData({
        'name': 'Wheat',
        'master_id': '2',
        'closingbalance': 10,
        'closingvalue': 2500,
        'baseunits': 'kg',
        'closingrate': 250,
        'standardcost': 200,
        'standardprice': 225,
      });

      // Ledger
      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('ledger')
          .document('1')
          .setData({
        'name': 'XYZ Ltd',
        'master_id': '1',
        'currencyname': 'Rupees',
        'opening_balance': 0,
        'closing_balance': 100000,
        'parentcode': '',
        'contact': '',
        'address': 'CP, New Delhi',
        'state': 'Delhi',
        'pincode': '110001',
        'email': 'xyz@email.com',
        'phone': '9999999999',
        'guid': '1',
        'gst': 'XXXXXXXXXXXX',
      });

      // Voucher
      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('voucher')
          .document('1')
          .setData({
        'date': DateTime.now(),
        'restat_party_ledger_name': 'XYZ Ltd',
        'amount': 10000,
        'master_id': '1',
        'is_cancelled': '0',
        'primary_voucher_type_name': 'Sales',
        'is_invoice': '1',
        'type': 'Sales',
        'party_legger_name': '1',
        'number': '1',
        'inventory_entries': [
          {
            'voucher_date': DateTime.now(),
            'voucher_master_id': '1',
            'rate': 220,
            'primary_voucher_type_name': 'Sales',
            'gstpercent': '18',
            'billedqty': 10,
            'actualqty': 10,
            'amount': 2596,
            'taxamount': 396,
          }
        ],
        'ledger_entries': [],
      });

      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('inventory_entries')
          .document('1')
          .setData({
        'restat_stock_item_name': 'Wheat',
        'restat_party_ledger_name': 'XYZ Ltd',
        'voucher_date': DateTime.now(),
        'voucher_master_id': '1',
        'rate': 220,
        'primary_voucher_type_name': 'Sales',
        'gstpercent': '18',
        'billedqty': 10,
        'actualqty': 10,
        'amount': 2596,
        'taxamount': 396,
      });

      // Firestore.instance
      //     .collection('company')
      //     .document(user.uid)
      //     .collection('ledger_entries');

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
