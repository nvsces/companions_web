import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/auth_services.dart';
import 'package:companions_web/screens/landing.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var firebaseApp = await Firebase.initializeApp();
  return runApp(CompanionsApp());
}

class CompanionsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<myUser>.value(
        value: AuthService().currentUser,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CompanionsP',
            theme: ThemeData(
                primaryColor: Color.fromRGBO(230, 148, 46, 1),
                textTheme: TextTheme(title: TextStyle(color: Colors.white))),
            home: LandingPage()));
  }
}
