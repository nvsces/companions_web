import 'package:companions_web/generated/l10n.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/home.dart';
import 'package:companions_web/services/auth.dart';
//import 'package:companions_web/services/auth_firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/auth_services.dart';

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
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            title: 'Попутчики в Земетчино',
            theme: ThemeData(
                primaryColor: Color.fromRGBO(230, 148, 46, 1),
                textTheme: TextTheme(title: TextStyle(color: Colors.white))),
            routes: <String, WidgetBuilder>{
              '/': (context) => HomePage(),
              '/auth': (context) => AuthorizationPage()
            }));
  }
}
