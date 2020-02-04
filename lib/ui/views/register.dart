import 'package:flutter/material.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/theme/colors.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String referralCode = '';

  @override
  Widget build(BuildContext context) {
    // return loading ? Loading() : Scaffold(
    return Scaffold(
      backgroundColor: TassistWhite,
      appBar: AppBar(
        backgroundColor: TassistPrimaryBackground,
        elevation: 0.0,
        title: Text('Sign up'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person, color: TassistWhite,),
            label: Text('Sign In', style: Theme.of(context).textTheme.body1.copyWith(
              color: TassistWhite
            ),),
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
                  icon: Icon(Icons.email, color: TassistPrimaryBackground),
                  hintText: 'Enter your email ID please',
                  labelText: 'Email'
                ),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                   icon: Icon(Icons.vpn_key, color: TassistPrimaryBackground),
                  hintText: 'Enter your password please',
                  labelText: 'Password'
                ),
                obscureText: true,
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                   icon: Icon(Icons.perm_contact_calendar, color: TassistPrimaryBackground),
                  hintText: 'Enter your referral code',
                  labelText: 'Referral Code'
                ),
                obscureText: true,
                validator: (val) =>
                    val.length < 6  ? 'Enter a referral code 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => referralCode = val);
                },
              ),

              SizedBox(height: 20.0),
             
        
              RaisedButton(
                  color: TassistPrimary,
                  elevation: 10.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: TassistWhite),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() => loading = true);
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Please supply a valid email';
                        });
                      }
                    }
                  }),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
