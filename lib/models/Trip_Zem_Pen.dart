import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/detail_trip.dart';
import 'package:companions_web/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Trip_Zem_Pen extends StatefulWidget {
  Trip_Zem_Pen({Key key}) : super(key: key);

  @override
  _Trip_Zem_PenState createState() => _Trip_Zem_PenState();
}

class _Trip_Zem_PenState extends State<Trip_Zem_Pen> {
  var trips = List<Trip>();

  DatabaseService db = DatabaseService();
  String route = 'Zem_Pen';
  bool _slowAnimations = false;
  myUser user;

  @override
  void initState() {
    loadData();
    super.initState();
  }

  loadData() async {
    var stream = db.getTrips(route);
    stream.listen((List<Trip> data) {
      setState(() {
        data.sort((a, b) => a.time.compareTo(b.time));
        trips = data;
        print(trips.length.toString());
      });
    });
  }

  void _deleteTrip(String pathDoc) async {
    await DatabaseService().deleteTrip(pathDoc, route);
  }

  Widget tripInfo(BuildContext context, Trip trip) {
    return Column(children: <Widget>[
      Text(
        trip.route,
        style: TextStyle(fontSize: 1000.0),
      ),
      //     Text(trip.seats),
      //    Text(trip.time)
    ]);
  }

  Color getColorCard(String group) {
    if (group == 'Водитель')
      return Colors.blue;
    else
      return Colors.green;
  }

  Widget getImageGroup(String group) {
    if (group == 'Водитель')
      return Image.asset(
        'assets/images/driver.jpg',
        scale: 3,
      );
    else
      return Image.asset(
        'assets/images/pas.jpg',
        scale: 6.5,
      );
  }

  Widget getDeleteButton(Trip trip) {
    if (user.id == null) return SizedBox();
    if (user.id == trip.author) {
      return IconButton(
        color: Colors.white,
        icon: Icon(Icons.delete),
        onPressed: () {
          _deleteTrip(trip.docPath);
        },
      );
    } else
      return SizedBox();
  }

  Widget listCard(Trip trip) {
    return Card(
        color: getColorCard(trip.group),
        child: ListTile(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (ctx) => DetailTrip(trip)));
            },
            leading: Column(
              children: <Widget>[getImageGroup(trip.group)],
              mainAxisSize: MainAxisSize.min,
            ),
            title: Text(
              trip.route,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            subtitle: Column(children: <Widget>[
              Text(trip.time,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold)),
              Text('Количество мест: ' + trip.seats,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold))
            ]),
            trailing: getDeleteButton(trip)));
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<myUser>(context);
    return Container(
      child: Container(
        child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, i) {
              return listCard(trips[i]);
            }),
      ),
    );
  }
}
