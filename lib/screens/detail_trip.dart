import 'package:companions_web/models/trip.dart';
import 'package:flutter/material.dart';

class DetailTrip extends StatelessWidget {
  final Trip trip;

  const DetailTrip(@required this.trip, {Key key}) : super(key: key);

  Widget getImageGroup(String group) {
    if (group == 'Водитель')
      return Image.asset(
        'assets/images/driver.jpg',
        scale: 1,
      );
    else
      return Image.asset(
        'assets/images/pas.jpg',
        scale: 1,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          getImageGroup(trip.group),
          Text(trip.route, style: TextStyle(fontSize: 30)),
          Text(trip.time, style: TextStyle(fontSize: 30)),
          Text('Количество мест: ' + trip.seats,
              style: TextStyle(fontSize: 30)),
          Text(trip.group, style: TextStyle(fontSize: 30)),
          Text('Номер телефона: ' + trip.phone, style: TextStyle(fontSize: 30)),
        ],
      )),
    );
  }
}
