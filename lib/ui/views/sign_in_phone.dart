import 'package:flutter/material.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/views/otp_verify.dart';

class SignInPhone extends StatefulWidget {
  final Function toggleView;
  SignInPhone({this.toggleView});

  @override
  _SignInPhoneState createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignInPhone> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String phone = '';

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
                .title
                .copyWith(color: TassistWhite)),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(
              Icons.person,
              color: TassistWhite,
            ),
            label: Text(
              'Register',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: TassistWhite),
            ),
            onPressed: () => widget.toggleView(),
          ),
        ],
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
                    hintText: 'Enter your phone please',
                    labelText: 'Phone'),
                validator: (val) => val.isEmpty ? 'Enter a phone' : null,
                onChanged: (val) {
                  setState(() => phone = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                  color: TassistPrimaryBackground,
                  elevation: 20.0,
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.verifyPhone(phone);

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) => PhoneAuthVerify(),
                        ),
                      );
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
