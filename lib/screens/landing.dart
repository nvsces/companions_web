import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myUser user = Provider.of<myUser>(context);
    final bool isLoggedIn = user != null;

    // return isLoggedIn ? HomePage() : AuthorizationPage();
    return LoginScreen();
  }
}
