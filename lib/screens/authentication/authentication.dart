// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool showSignIn = true;

  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  } 

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView : toggleView); 
    } else {
      return Register(toggleView : toggleView );
    }
  }
}
