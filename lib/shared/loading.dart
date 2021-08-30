// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color : Colors.greenAccent,
      child : SpinKitChasingDots(
        color : Colors.white ,
        size : 50.0 ,
      )
    );
  }
}


// add loading :  Loader() before Scaffold  