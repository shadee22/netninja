// ignore_for_file: unnecessary_null_comparison, avoid_print, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meowing/models/user.dart';
import 'package:meowing/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebased user
  MyUser? _fromFirebaseUser(user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  Stream<MyUser?> get user {
    return _auth.authStateChanges().map(_fromFirebaseUser);
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _fromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in email and password

  Future signInWithEmailAndPassword(String _email, String _password) async {
    try {
      UserCredential _result = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      User? _user = _result.user;
      return _fromFirebaseUser(_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register in email and password
  Future registerWithEmailAndPassword(String _email, String _password) async {
    try {
      UserCredential _result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      User? _user = _result.user;
      await DatabaseService(uid: _user!.uid)
          .updateUserData('0', 'shadeer', 100);
      await DatabaseService(name: _email).updateNameData(_email , _password );
      return _fromFirebaseUser(_user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out

  Future SignOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
