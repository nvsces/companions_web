import 'package:companions_web/const.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/detail_trip.dart';
import 'package:companions_web/screens/home.dart';
import 'package:companions_web/services/auth.dart';
import 'package:companions_web/services/auth_firebase.dart';
import 'package:companions_web/services/auth_services.dart';
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
        value: AuthFirebase().currentUser,
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: main_title,
            theme: ThemeData(
                primaryColor: Color.fromRGBO(230, 148, 46, 1),
                textTheme: TextTheme(title: TextStyle(color: Colors.white))),
            routes: <String, WidgetBuilder>{
              '/': (context) => HomePage(),
              '/auth': (context) => AuthorizationPage()
            }));
  }
}
