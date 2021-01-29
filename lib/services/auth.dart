import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/home.dart';
import 'package:companions_web/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _email;
  String _password;
  bool showLogin = true;

  void _loginButtonAction() async {
    print('Точка входа');
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    myUser user = await AuthService()
        .signInWithEmailAndPassword(_email.trim(), _password.trim());

    if (user == null) {
      Fluttertoast.showToast(
          msg: "This is Center Short Toast",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      _emailController.clear();
      _passwordController.clear();
      Navigator.pop(context);
    }
  }

  void _registrButtonAction() async {
    _email = _emailController.text;
    _password = _passwordController.text;

    if (_email.isEmpty || _password.isEmpty) return;

    myUser user = await AuthService()
        .registrWithEmailAndPassword(_email.trim(), _password.trim());

    if (user == null) {
      Fluttertoast.showToast(msg: 'Toast work');
    } else {
      _emailController.clear();
      _passwordController.clear();
    }
  }

  //AuthService _authService = AuthService();

  Widget _buildlogo() {
    return Container(
        child: Align(
            child: Text('Попутчики Земетчино',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))));
  }

  Widget _input(
      Icon icon, String hint, TextEditingController controller, bool obscure) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        style: TextStyle(fontSize: 20, color: Colors.white),
        decoration: InputDecoration(
            hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white30),
            hintText: hint,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white54, width: 1)),
            prefixIcon: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: IconTheme(
                    data: IconThemeData(color: Colors.white), child: icon))),
      ),
    );
  }

  Widget _button(String text, void func()) {
    return RaisedButton(
      splashColor: Theme.of(context).primaryColor,
      highlightColor: Theme.of(context).primaryColor,
      color: Colors.white,
      child: Text(text,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
              fontSize: 20)),
      onPressed: () {
        func();
      },
    );
  }

  Widget _form(String label, void func()) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(bottom: 20, top: 10),
              child:
                  _input(Icon(Icons.email), 'EMAIL', _emailController, false)),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child:
                _input(Icon(Icons.lock), 'PASSWORD', _passwordController, true),
          ),
          SizedBox(height: 20),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                  height: 30,
                  width: MediaQuery.of(context).size.width,
                  child: _button(label, func)))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AuthService().persistens();

    return Scaffold(
        appBar: AppBar(title: Text('Аутентификация')),
        backgroundColor: Theme.of(context).primaryColor,
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _buildlogo(),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _form('ВОЙТИ', _loginButtonAction),
                  ],
                )
              ],
            )));
  }
}
