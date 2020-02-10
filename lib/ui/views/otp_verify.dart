import 'package:flutter/material.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/theme/colors.dart';

class PhoneAuthVerify extends StatefulWidget {
  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String otp = '';

  @override
  Widget build(BuildContext context) {
    // return loading ? Loading() : Scaffold(
    return Scaffold(
      backgroundColor: TassistWhite,
      appBar: AppBar(
        backgroundColor: TassistPrimary,
        elevation: 0.0,
        title: Text('Get OTP',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: TassistWhite)),
        // actions: <Widget>[
        //   FlatButton.icon(
        //     icon: Icon(
        //       Icons.person,
        //       color: TassistWhite,
        //     ),
        //     label: Text(
        //       'Register',
        //       style: Theme.of(context)
        //           .textTheme
        //           .bodyText1
        //           .copyWith(color: TassistWhite),
        //     ),
        //     onPressed: () => widget.toggleView(),
        //   ),
        // ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.phone, color: TassistPrimaryBackground),
                    hintText: 'Verify OTP',
                    labelText: 'OTP'),
                validator: (val) => val.isEmpty ? 'Verify OTP' : null,
                onChanged: (val) {
                  setState(() => otp = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: TassistPrimaryBackground,
                  elevation: 20.0,
                  child: Text(
                    'Verify OTP',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.signInWithPhone(smsCode: otp);
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
