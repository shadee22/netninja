// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'package:flutter/material.dart';
import 'home/home.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';
import 'authentication/authentication.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);
    print(user);

    //Authentication or Home Page
    if (user == null) {
      return Authentication();
    } else {
      return Home();
    }
  }
}
