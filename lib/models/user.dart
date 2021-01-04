import 'package:firebase_auth/firebase_auth.dart';

// ignore: camel_case_types
class myUser {
  String id;

  myUser.fromFirebase(User user) {
    id = user.uid;
  }
}
