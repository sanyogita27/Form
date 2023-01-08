import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:login_form1/database_manager.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future createNewUser(String name, String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DatabaseManager().createUserData(name, email, 'Female', user!.uid);
      return user;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future loginUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return result.user;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future signOut() async {
    try {
      return _auth.signOut();
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
