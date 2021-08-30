// ignore_for_file: use_key_in_widget_constructors, unused_field, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use, avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:meowing/shared/constraints.dart';
import 'package:provider/provider.dart';
import 'package:meowing/models/user.dart';
import 'package:meowing/services/database.dart';
import 'package:meowing/shared/loading.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _settingsFormKey = GlobalKey<FormState>();

  List<String> sugers = ['0', '1', '2', '3', '4', '5'];

  String? _currentSuger;
  String? _currentName;
  int? _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, AsyncSnapshot<UserData> snapshot) {
          if (snapshot.hasData) {
            UserData? userData = snapshot.data;
            // print("i am the strength $_currentStrength!");
            // print(userData!.name);
            // var _user_name = userData.name;
            // var _user_strength = userData.strength;
            // var _user_suger = userData.suger;

            // _currentName = _user_name!;
            // _currentSuger = _user_suger!;
            // _currentStrength = _user_strength!.toInt();

            return Form(
              key: _settingsFormKey,
              child: Column(
                children: <Widget>[
                  Text("Shadeer's Details", style: TextStyle(fontSize: 20.0)),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: userData!.name,
                    decoration:
                        textinputdecoration.copyWith(hintText: 'Name Here'),
                    validator: (val) =>
                        val.toString().isEmpty ? 'Enter a name' : null,
                    onChanged: (val) => _currentName = val,
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    decoration:
                        textinputdecoration.copyWith(hintText: 'suger level'),
                    items: sugers.map((suger) {
                      return DropdownMenuItem(
                        value: suger,
                        child: Text('$suger sugers'),
                      );
                    }).toList(),
                    onChanged: (val) {
                      setState(() {
                        _currentSuger = val.toString();
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  Slider(
                    value: ( _currentStrength ??  userData.strength!).toDouble(),
                    activeColor: Colors.brown[_currentStrength ?? userData.strength!],
                    inactiveColor: Colors.brown[_currentStrength ?? userData.strength!],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrength  = val.round()),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    onPressed: () {
                      if (_settingsFormKey.currentState!.validate()) {
                        DatabaseService(uid: user.uid).updateUserData(
                            _currentSuger ?? userData.suger!,
                            _currentName ?? userData.name!,
                            _currentStrength ?? userData.strength! , 
                            );
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Slam That Button !',
                        style: TextStyle(color: Colors.white)),
                    color: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  )
                ],
              ),
            );
          } else {
            return Loader();
          }
        });
  }
}
