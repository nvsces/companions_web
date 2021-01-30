import 'package:companions_web/models/listTrip/Trip_Mos_Zem.dart';
import 'package:companions_web/models/listTrip/Trip_Pen_zem.dart';
import 'package:companions_web/models/listTrip/Trip_Zem_Mos.dart';
import 'package:companions_web/models/listTrip/Trip_Zem_Pen.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/add_trip.dart';
import 'package:companions_web/services/auth.dart';
import 'package:companions_web/services/auth_services.dart';
import 'package:companions_web/services/const.dart';
import 'package:companions_web/services/database.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService db = DatabaseService();
  int sectionIndex = 0;
  String route = PenZem;
  String vkUrl = "";

  loadUrl(myUser user) async {
    var stream = db.getVkUrl(user.id);
    stream.listen((String data) {
      setState(() {
        vkUrl = data;
      });
    });
  }

  String getRouteWidgetList(int itemIndex) {
    switch (itemIndex) {
      case 0:
        return PenZem;
        break;
      case 1:
        return ZemPen;
        break;
      case 2:
        return ZemMos;
        break;
      case 3:
        return MosZem;
        break;
      default:
        return PenZem;
    }
  }

  Widget bodyItem(int itemIndex) {
    switch (itemIndex) {
      case 0:
        return Trip_Pen_Zem();
        //return TestUrl();
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

  AppBar buildAppBar(bool isLogged) {
    return AppBar(
        backgroundColor: Colors.orange,
        centerTitle: true,
        title: Text(
          'Попутчики Земетчино',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          isLogged
              ? FlatButton.icon(
                  onPressed: () => AuthService().logOut(),
                  icon: Icon(Icons.supervised_user_circle, color: Colors.white),
                  label: Text(
                    'Выход',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : FlatButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => AuthorizationPage()));
                  },
                  icon: Icon(Icons.supervised_user_circle, color: Colors.white),
                  label: Text(
                    'Вход',
                    style: TextStyle(color: Colors.white),
                  ),
                )
        ]);
  }

  @override
  Widget build(BuildContext context) {
    final myUser user = Provider.of<myUser>(context);
    final bool isLoggedIn = user != null;
    loadUrl(user);
    CurvedNavigationBar navigationBar = CurvedNavigationBar(
        items: const <Widget>[
          Text('Пен-Зем'),
          Text('Зем-Пен'),
          Text('Зем-Мос'),
          Text('Мос-Зем')
        ],
        index: 0,
        height: 50,
        color: Colors.orange,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.white.withOpacity(0.5),
        animationCurve: Curves.easeOutQuint,
        animationDuration: Duration(milliseconds: 500),
        onTap: (int index) async {
          setState(() {
            sectionIndex = index;
            route = getRouteWidgetList(index);
          });
        });
    Widget scaffold = Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(isLoggedIn),
      body: bodyItem(sectionIndex),
      bottomNavigationBar: navigationBar,
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.white,
              foregroundColor: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => AddTrip(sectionIndex, vkUrl)));
              },
            )
          : SizedBox(),
    );
    return Provider<String>(
        create: (context) => getRouteWidgetList(sectionIndex), child: scaffold);
  }
}
