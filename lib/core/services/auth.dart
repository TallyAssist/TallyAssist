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

      Firestore.instance.collection('metrics').document(user.uid).setData({
        'total_sales': 100000,
        'total_payments': 0,
        'total_purchases': 50000,
        'total_receipts': 0,
        'out_actual_rec': 100000,
        'out_actual_pay':50000,
      });

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
        'name': 'ABC Ltd',
        'master_id': '1',
        'currencyname': 'Rupees',
        'opening_balance': 0,
        'closing_balance': -100000,
        'parentcode': '20',
        'contact': '',
        'address': 'CP, New Delhi',
        'state': 'Delhi',
        'pincode': '110001',
        'email': 'xyz@email.com',
        'phone': '9999999999',
        'guid': '1',
        'gst': 'XXXXXXXXXXXX',
        'restat_primary_group_type': 'Sundry Debtors',
        'restat_total_receivables': 100000,
        'restat_total_payables': 0,
      },
      );

       Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('ledger')
          .document('2')
          .setData(
      {
      'name': 'Cash',
        'master_id': '2',
        'currencyname': 'Rupees',
        'opening_balance': 1000,
        'closing_balance': 101000,
        'parentcode': '',
        'contact': '',
        'address': '',
        'state': 'Delhi',
        'pincode': '110001',
        'email': '',
        'phone': '',
        'guid': '2',
        'gst': '',
         'restat_primary_group_type': '',
         'restat_total_receivables': '',
        'restat_total_payables': ''
      },
      );

 Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('ledger')
          .document('3')
          .setData(
      {
      'name': 'BCD Ltd',
        'master_id': '3',
        'currencyname': 'Rupees',
        'opening_balance': 0,
        'closing_balance': 50000,
        'parentcode': '16',
        'contact': '',
        'address': 'CP, New Delhi',
        'state': 'Delhi',
        'pincode': '110001',
        'email': 'abc@email.com',
        'phone': '9898989898',
        'guid': '3',
        'gst': 'ABCD1234PQ56',
        'restat_primary_group_type': 'Sundry Creditors',
        'restat_total_receivables': 0,
        'restat_total_payables': 50000
      }
      );

Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('ledger')
          .document('4')
          .setData(
      {
      'name': 'GST @ 18%',
        'master_id': '4',
        'currencyname': 'Rupees',
        'opening_balance': 0,
        'closing_balance': 396,
        'parentid': '',
        'contact': '',
        'address': 'CP, New Delhi',
        'state': 'Delhi',
        'pincode': '',
        'email': '',
        'phone': '9898989898',
        'guid': '4',
        'gst': '',
        
      }
      );


      // Voucher
      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('voucher')
          .document('1')
          .setData({
        'date': DateTime.now(),
        'restat_party_ledger_name': 'ABC Ltd',
        'amount': 10000,
        'master_id': '1',
        'guid': '1',
        'is_cancelled': '0',
        'primary_voucher_type_name': 'Sales',
        'is_invoice': '1',
        'type': 'Sales',
        'party_ledger_name': '1',
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
        'ledger_entries': [
          {
            'amount':'2200',
            'isdeemedpositive':'1',
            'ledger_guid': '1',
            'ispartyledger':'1',
            'ledger_guid':'1',
            'ledgername':'1',
            'ledgerrefname':'',
            'parent':'',
            'primarygroup':''
          },
          {
            'amount':'396',
            'isdeemedpositive':'1',
            'ledger_guid': '4',
            'ispartyledger':'0',
            'ledger_guid':'1',
            'ledgername':'1',
            'ledgerrefname':'',
            'parent':'',
            'primarygroup':''
          }



        ],
      });

      // Ledger Stock

      Firestore.instance
          .collection('company')
          .document(user.uid)
          .collection('ledger')
          .document('1')
          .collection('ledger_stock_metrics')
          .document('1')
          .setData({
            
              'last_amount':'2596',
              'last_discount': '0',
              'last_rate': '220',
              'last_voucher_date': DateTime.now(),
              'mean_amount': '2596',
              'num_vouchers': '1',
              'restat_stock_item_name': 'Wheat', 
              'stockitemname':'1',
              'total_actualqty': '10',
              'total_amount':'2596',
              'total_billedqty': 10,
              'voucher_type': 'Sales' 

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
