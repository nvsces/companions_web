import 'package:companions_web/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase.dart' as firebase;

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  void persistens() {
    _fAuth.setPersistence(Persistence.LOCAL);
  }

  Future<ConfirmationResult> sendCode(String phone) async {
    var recapcha = RecaptchaVerifier(
      onSuccess: () {
        print('reCAPTCHA завершена!');
      },
      onError: (FirebaseAuthException error) => print(error),
      onExpired: () => print('reCAPTCHA Expired!'),
    );
    ConfirmationResult confirmationResult =
        await _fAuth.signInWithPhoneNumber(phone, recapcha);
    return confirmationResult;
  }

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

  Future<myUser> signInPhone(ConfirmationResult confirm, String code) async {
    try {
      var result = await confirm.confirm(code);
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

  Stream<myUser> firstUser() {
    _fAuth.authStateChanges();
  }

  Stream<myUser> get currentUser {
    return _fAuth
        .authStateChanges()
        .map((User user) => user != null ? myUser.fromFirebase(user) : null);
  }
}
