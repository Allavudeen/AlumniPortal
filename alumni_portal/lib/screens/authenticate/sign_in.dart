import 'package:alumni_portal/screens/home/home.dart';
import 'package:alumni_portal/services/auth.dart';
import 'package:alumni_portal/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal/shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text fields declaration
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.blue[100],
            appBar: AppBar(
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              title: Text('Sign in to Alumni Portal'),
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Register'),
                  onPressed: () {
                    widget.toggleView();
                  },
                )
              ],
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage('assets/bg-image.jpg'),
                fit: BoxFit.cover,
              )),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) => val.isEmpty ? "Enter EMail" : null,
                        onChanged: (val) {
                          setState(() {
                            email = val.trim();
                          });
                        }),
                    SizedBox(height: 10.0),
                    TextFormField(
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Password'),
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? "Enter Password 6+ chars long"
                            : null,
                        onChanged: (val) {
                          setState(() {
                            password = val.trim();
                          });
                        }),
                    SizedBox(height: 10.0),
                    RaisedButton(
                      color: Colors.blue[400],
                      child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: () async {
                        //print(email);
                        //print(password);
                        if (_formKey.currentState.validate()) {
                          //print(email);
                          //print(password);
                          //print('valid');
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.signInWithEmailAndPassword(
                                  email.trim(), password);
                          if (result == null) {
                            setState(() {
                              error =
                                  'Could not sign in with the credentials provided';
                              loading = false;
                            });
                          } else if (result != null) {
                            //Navigator.pop(context);
                            Home();
                          }
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
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
