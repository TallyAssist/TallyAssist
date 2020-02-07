// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:tassist/ui/views/dashboard.dart';



// class LocalAuth extends StatefulWidget {
//   @override
//   _LocalAuthState createState() => _LocalAuthState();
// }

// class _LocalAuthState extends State<LocalAuth> {

//   final LocalAuthentication auth = LocalAuthentication();
//   bool _canCheckBiometrics;
//   List<BiometricType> _availableBiometrics;
//   String _authorized = 'Not Authorized';
//   bool _isAuthenticating = false;

//   Future<void> _checkBiometrics() async {
//     bool canCheckBiometrics;
//     try {
//       canCheckBiometrics = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) return;

//     setState(() {
//       _canCheckBiometrics = canCheckBiometrics;
//     });
//   }

//   Future<void> _getAvailableBiometrics() async {
//     List<BiometricType> availableBiometrics;
//     try {
//       availableBiometrics = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) return;

//     setState(() {
//       _availableBiometrics = availableBiometrics;
//     });
//   }

//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticateWithBiometrics(
//           localizedReason: 'Scan your fingerprint to authenticate',
//           useErrorDialogs: true,
//           stickyAuth: true);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Authenticating';
//       });
//     } on PlatformException catch (e) {
//       print(e);
//     }
//     if (!mounted) return;

//     final String message = authenticated ? 'Authorized' : 'Not Authorized';
//     setState(() {
//       _authorized = message;
//     });
//   }

//   void _cancelAuthentication() {
//     auth.stopAuthentication();
//   }

//   @override
//   Widget build(BuildContext context) {

//     _checkBiometrics().then((onValue) => {
//       _getAvailableBiometrics().then((onValue) => {
//         _authenticate()
//       })
//     });
//     // _isAuthenticating ? _cancelAuthentication : _authenticate,
//   }
// }

