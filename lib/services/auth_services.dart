import 'package:companions_web/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<myUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return myUser.fromFirebase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<myUser> registrWithEmailAndPassword(
      String email, String password) async {
    try {
      var result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return myUser.fromFirebase(user);
    } catch (e) {
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<myUser> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User user) => user != null ? myUser.fromFirebase(user) : null);
  }
}
