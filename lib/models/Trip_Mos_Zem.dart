import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/services/database.dart';
import 'package:flutter/material.dart';

class Trip_Mos_Zem extends StatefulWidget {
  Trip_Mos_Zem({Key key}) : super(key: key);

  @override
  _Trip_Mos_ZemState createState() => _Trip_Mos_ZemState();
}

class _Trip_Mos_ZemState extends State<Trip_Mos_Zem> {
  var trips = List<Trip>();

  DatabaseService db = DatabaseService();
  String route = 'Mos_Zem';

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
        trips = data;
      });
    });
  }

  void _deleteTrip(String pathDoc) async {
    await DatabaseService().deleteTrip(pathDoc, route);
  }

  Widget tripInfo(BuildContext context, Trip trip) {
    return Column(children: <Widget>[
      Text(trip.route),
      //     Text(trip.seats),
      //    Text(trip.time)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, i) {
              return Card(
                  elevation: 2.0,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Container(
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      leading: Container(
                        padding: EdgeInsets.only(right: 12),
                        child: Icon(
                          Icons.car_repair,
                          color: Colors.black,
                        ),
                      ),
                      title: tripInfo(context, trips[i]),
                      subtitle: Column(
                        children: <Widget>[
                          Text(trips[i].time),
                          Text('Количество мест: ' + trips[i].seats),
                          Text(trips[i].phone),
                          Text(trips[i].group)
                        ],
                      ),
                      trailing: Column(
                        children: <Widget>[
                          // ignore: missing_required_param
                          IconButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deleteTrip(trips[i].docPath);
                            },
                          ),
                        ],
                      ),
                    ),
                  ));
            }),
      ),
    );
  }
}
