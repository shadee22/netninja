// ignore_for_file: unused_local_variable, unnecessary_null_comparison, prefer_const_declarations, unused_import, duplicate_ignore, use_key_in_widget_constructors, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:meowing/services/auth.dart';
import 'package:meowing/services/database.dart';
import 'package:provider/provider.dart';
import 'package:meowing/models/brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meowing/screens/home/home.dart';
import 'package:meowing/models/name.dart';
import 'package:meowing/screens/home/name_tile.dart';
import 'package:meowing/shared/loading.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brew = Provider.of<List<Brew>?>(context);
    if (brew != null) {
      return ListView.builder(
        itemCount: brew.length,
        itemBuilder: (context, index) {
          return BrewTile(brew: brew[index]);
        },
      );
    } else {
      return Loader();
    }

    
  }
}
