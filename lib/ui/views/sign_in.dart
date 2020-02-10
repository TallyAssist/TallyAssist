import 'package:flutter/material.dart';
import 'package:tassist/core/services/auth.dart';
import 'package:tassist/theme/colors.dart';
import 'package:tassist/ui/root_page.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    // return loading ? Loading() : Scaffold(
    return Scaffold(
      backgroundColor: TassistWhite,
      appBar: AppBar(
        backgroundColor: TassistPrimary,
        elevation: 0.0,
        title: Text('Sign In',
            style: Theme.of(context)
                .textTheme
                .headline6
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
                  .bodyText1
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
                    icon: Icon(Icons.email, color: TassistPrimaryBackground),
                    hintText: 'Enter your email ID please',
                    labelText: 'Email'),
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.vpn_key, color: TassistPrimaryBackground),
                    hintText: 'Enter your password please',
                    labelText: 'Password'),
                validator: (val) =>
                    val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
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
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          loading = false;
                          error = 'Could not sign in with those credentials';
                        });
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => RootPage(),
                          ),
                        );
                      }
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
