// import 'package:flutter/material.dart';
// import 'package:flutter_login/flutter_login.dart';
// import './dashboard.dart';

// const users = const {
//   'akash@restat.co': 'restat12345',
//   'richa@restat.co': 'restat12345',
// };

// class LoginScreen extends StatelessWidget {
//   Duration get loginTime => Duration(milliseconds: 2250);

//   Future<String> _authUser(LoginData data) {
//     print('Name: ${data.name}, Password: ${data.password}');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(data.name)) {
//         return 'Username not exists';
//       }
//       if (users[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return null;
//     });
//   }

//   Future<String> _recoverPassword(String name) {
//     print('Name: $name');
//     return Future.delayed(loginTime).then((_) {
//       if (!users.containsKey(name)) {
//         return 'Username not exists';
//       }
//       return null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       title: 'BizAssist',
//       logo: 'assets/images/ecorp-lightblue.png',
//       onLogin: _authUser,
//       onSignup: _authUser,
//       onSubmitAnimationCompleted: () {
//         Navigator.of(context).pushReplacement(MaterialPageRoute(
//           builder: (context) => DashboardScreen(),
//         ));
//       },
//       onRecoverPassword: _recoverPassword,
//     );
//   }
// }
