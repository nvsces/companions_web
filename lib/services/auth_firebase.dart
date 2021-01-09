import 'package:companions_web/models/user.dart';
import 'package:firebase/firebase.dart' as firebase;
import 'package:firebase/firebase.dart';

class AuthFirebase {
  final firebase.Auth _fAuth = firebase.auth();

  Future<myUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      var rezult = await _fAuth.signInWithEmailAndPassword(email, password);
      firebase.User user = rezult.user;
      return myUser.fromFirebaseUser(user);
    } catch (e) {
      print(e);
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<myUser> get currentUser {
    return _fAuth.onAuthStateChanged.map((firebase.User user) =>
        user != null ? myUser.fromFirebaseUser(user) : null);
  }
}
