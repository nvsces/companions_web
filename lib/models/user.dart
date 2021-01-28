import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase.dart' as firebase;

// ignore: camel_case_types
class myUser {
  String id;
// for android and ios
  myUser.fromFirebase(User user) {
    id = user.uid;
  }
  // for web
  myUser.fromFirebaseUser(firebase.User user) {
    id = user.uid;
  }
}
