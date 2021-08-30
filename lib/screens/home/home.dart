// ignore_for_file: use_key_in_widget_constructors, avoid_unnecessary_containers, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meowing/screens/home/setting_form.dart';
import 'package:meowing/services/auth.dart';
import 'package:meowing/services/database.dart';
import 'package:provider/provider.dart';
import 'package:meowing/screens/home/brew_list.dart';
import 'package:meowing/models/brew.dart';
import 'package:meowing/models/name.dart';
import 'package:meowing/models/user.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: SettingsForm(),
          );
        },
      );
    }
    final user = Provider.of<MyUser>(context);

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService().brew,
      initialData: null,
      child: MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.brown[50],
            appBar: AppBar(
              title: Text('ShadyApp'),
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              actions: [
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Log Out'),
                  onPressed: () async {
                    await _auth.SignOut();
                  },
                ),
                FlatButton.icon(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                  onPressed: () => _showSettingsPanel(),
                ),
              ],
            ),
            body: BrewList()),
      ),
    );
  }
}
