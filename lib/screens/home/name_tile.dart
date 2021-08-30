// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:meowing/models/brew.dart';

class BrewTile extends StatelessWidget {
  final Brew brew ;
  BrewTile({required this.brew});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25, 
            backgroundColor: Colors.brown[brew.strength!],
          ),
          title: Text("${brew.name}"),
          subtitle: Text('Takes ${brew.sugers}'),
          trailing: Icon(Icons.more_vert),
        ),
      ),
    );
  }
}
