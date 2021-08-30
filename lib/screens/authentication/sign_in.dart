// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors, avoid_print, non_constant_identifier_names, unused_field, await_only_futures

import 'package:flutter/material.dart';
import 'package:meowing/services/auth.dart';
import 'package:meowing/shared/constraints.dart';
import 'package:meowing/shared/loading.dart';


class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _signinformkey = GlobalKey<FormState>();

  bool loading = false;
  String _email = '';
  String _password = '';
  String _error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loader() :  Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
          title: Text('Sign In To Shady App'),
          backgroundColor: Colors.brown[800],
          elevation: 0.0,
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Register'),
              onPressed: () {
                widget.toggleView();
              },
            )
          ]),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
        child: Form(
          key: _signinformkey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              TextFormField(
                // Email
                decoration:
                    textinputdecoration.copyWith(hintText: 'Email Here'),
                validator: (val) =>
                    val!.isEmpty ? 'Enter a Valid Password' : null,
                onChanged: (val) {
                  setState(() => _email = val);
                },
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                // Password
                decoration:
                    textinputdecoration.copyWith(hintText: 'Password Here'),
                validator: (val) => val!.length < 6
                    ? 'Enter a password More than 6 Charecters'
                    : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => _password = val);
                },
              ),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                color: Colors.red,
                onPressed: () async {
                  setState(() => loading = true);
                  if (_signinformkey.currentState!.validate()) {
                    dynamic _result =
                        await _auth.signInWithEmailAndPassword(_email, _password);
                    if (_result == null) {
                      setState(() => _error = 'Please Register First');
                      setState(() => loading = false);
                    }
                  }
                },
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 50),
              Text(
                _error,
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
