import 'package:companions_web/models/Trip_Mos_Zem.dart';
import 'package:companions_web/models/Trip_Pen_zem.dart';
import 'package:companions_web/models/Trip_Zem_Mos.dart';
import 'package:companions_web/models/Trip_Zem_Pen.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/add_trip.dart';
import 'package:companions_web/screens/login.dart';
import 'package:companions_web/services/auth_services.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  Widget bodyItem(int itemIndex) {
    switch (itemIndex) {
      case 0:
        return Trip_Pen_Zem();
        break;
      case 1:
        return Trip_Zem_Pen();
        break;
      case 2:
        return Trip_Zem_Mos();
        break;
      case 3:
        return Trip_Mos_Zem();
        break;
      default:
        return Trip_Pen_Zem();
    }
  }

  @override
  Widget build(BuildContext context) {
    final myUser user = Provider.of<myUser>(context);
    final bool isLoggedIn = user != null;
    var navigationBar = CurvedNavigationBar(
      items: const <Widget>[
        Text('Пен-Зем'),
        Text('Зем-Пен'),
        Text('Зем-Мос'),
        Text('Мос-Зем')
      ],
      index: 0,
      height: 50,
      color: Theme.of(context).primaryColor,
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.5),
      animationCurve: Curves.easeOutQuint,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index) async {
        setState(() => sectionIndex = index);
      },
    );

    AppBar buildAppBar() {
      return AppBar(
          backgroundColor: Colors.white,
          leading: Image.asset(
            'assets/images/dse.jpg',
            scale: 2,
          ),
          // On Android by default its false
          centerTitle: true,
          title: Image.asset("assets/images/olen.png"),
          actions: <Widget>[
            isLoggedIn
                ? FlatButton.icon(
                    onPressed: () => AuthService().logOut(),
                    icon: Icon(Icons.supervised_user_circle,
                        color: Theme.of(context).primaryColor),
                    label: Text('Выход'),
                  )
                : FlatButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (ctx) => LoginScreen()));
                    },
                    icon: Icon(Icons.supervised_user_circle,
                        color: Theme.of(context).primaryColor),
                    label: Text('Вход'),
                  )
          ]);
    }

    var scaffold = Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: bodyItem(sectionIndex),
      bottomNavigationBar: navigationBar,
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => AddTrip(sectionIndex)));
              },
            )
          : SizedBox(),
    );
    return Container(
      child: scaffold,
    );
  }
}
