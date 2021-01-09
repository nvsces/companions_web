import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase.dart' as firebase;

// ignore: camel_case_types
class myUser {
  String id;

  myUser.fromFirebase(User user) {
    id = user.uid;
  }
  myUser.fromFirebaseUser(firebase.User user) {
    id = user.uid;
  }
}
