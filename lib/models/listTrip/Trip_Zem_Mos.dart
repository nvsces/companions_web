import 'package:companions_web/models/listTrip/abstractList.dart';
import 'package:companions_web/models/trip.dart';
import 'package:companions_web/services/database.dart';
import 'package:flutter/material.dart';
import 'package:companions_web/screens/edit_trip.dart';

class Trip_Zem_Mos extends StatefulWidget {
  Trip_Zem_Mos({Key key}) : super(key: key);

  @override
  _Trip_Zem_MosState createState() => _Trip_Zem_MosState();
}

class _Trip_Zem_MosState extends State<Trip_Zem_Mos> with AbsctractList {
  //var trips = List<Trip>();
  List<Trip> trips = [];

  DatabaseService db = DatabaseService();
  String route = 'Zem_Mos';

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
