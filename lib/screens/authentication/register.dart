// ignore_for_file: use_key_in_widget_constructors, override_on_non_overriding_member, annotate_overrides, prefer_const_constructors, deprecated_member_use, await_only_futures, avoid_print, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:meowing/services/auth.dart';
import 'package:meowing/shared/constraints.dart';
import 'package:meowing/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>();

  @override
  AuthService _auth = AuthService();

  String _email = '';
  String _error = '';
  String _password = '';
  bool loading = false;

  Widget build(BuildContext context) {
    return loading
        ? Loader()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
                title: Text('Register Here!'),
                backgroundColor: Colors.brown[400],
                actions: [
                  FlatButton.icon(
                    icon: Icon(Icons.person),
                    label: Text('Sign In'),
                    onPressed: () {
                      widget.toggleView();
                    },
                  ),
                ]),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 50.0),
              child: Column(
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          // Email
                          decoration: textinputdecoration.copyWith(
                              hintText: 'Email Here'),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter a Email' : null,
                          onChanged: (val) {
                            setState(() => _email = val);
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          // Password
                          decoration: textinputdecoration.copyWith(
                              hintText: 'Password Here'),
                          validator: (val) => val!.length < 6
                              ? 'Add Password more than 6 Chars Long'
                              : null,
                          obscureText: true,
                          onChanged: (val) {
                            setState(() => _password = val);
                          },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () async {
                            if (_formkey.currentState!.validate()) {
                              setState(() => loading = true);
                              dynamic _result =
                                  await _auth.registerWithEmailAndPassword(
                                      _email, _password);
                              if (_result == null) {
                                setState(
                                    () => _error = 'Pls Enter a Valid Email ');
                                setState(() => loading = false);
                              }
                            }
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          _error,
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
