import 'package:companions_web/models/listTrip/abstractList.dart';
import 'package:companions_web/models/trip.dart';
import 'package:companions_web/screens/edit_trip.dart';
import 'package:companions_web/services/database.dart';
import 'package:flutter/material.dart';

class Trip_Mos_Zem extends StatefulWidget {
  Trip_Mos_Zem({Key key}) : super(key: key);

  @override
  _Trip_Mos_ZemState createState() => _Trip_Mos_ZemState();
}

class _Trip_Mos_ZemState extends State<Trip_Mos_Zem> with AbsctractList {
  DatabaseService db = DatabaseService();
  List<Trip> trips = [];
  String route = 'Mos_Zem';

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return buildAbsrtactList(context);
  }

  @override
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

  @override
  void deleteTrip(String pathDoc) async {
    await DatabaseService().deleteTrip(pathDoc, route);
  }

  @override
  void editTrip(Trip trip) {
    int sectionIndex = getRouteInSectiomIndex(trip.route);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => EditTrip(sectionIndex, initialTrip: trip)));
  }
}
