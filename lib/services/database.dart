// ignore_for_file: unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meowing/models/brew.dart';
import 'package:meowing/models/name.dart';
import 'package:meowing/models/user.dart';

class DatabaseService {
  final String? uid;
  final String? name;

  DatabaseService({
    this.uid,
    this.name,
  });

  final CollectionReference nameCollection =
      FirebaseFirestore.instance.collection('names');

  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');

  Future updateNameData(String email, String password) async {
    return await nameCollection
        .doc(name)
        .set({'email': email, 'password': password});
  }

  Future updateUserData(String sugers, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'name': name,
      'sugers': sugers,
      'strength': strength,
    });
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.get('name') ?? 'shadeer',
      suger: snapshot.get('sugers') ?? 'no ',
      strength: snapshot.get('strength') ?? 'hello',
    );
  }

  List<Brew> _listFromBrewSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Brew(
        sugers: doc.get('sugers'),
        name: doc.get('name') ,
        strength: doc.get('strength') ,
      );
    }).toList();
  }

  Stream<List<Brew>> get brew {
    return brewCollection.snapshots().map(_listFromBrewSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
