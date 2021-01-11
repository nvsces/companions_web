import 'package:companions_web/models/listTrip/abstractList.dart';
import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/detail_trip.dart';
import 'package:companions_web/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Trip_Pen_Zem extends StatefulWidget {
  Trip_Pen_Zem({Key key}) : super(key: key);

  @override
  _Trip_Pen_ZemState createState() => _Trip_Pen_ZemState();
}

class _Trip_Pen_ZemState extends State<Trip_Pen_Zem> with AbsctractList {
  var trips = List<Trip>();

  DatabaseService db = DatabaseService();
  String route = 'Pen_Zem';

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
    //
  }
}
