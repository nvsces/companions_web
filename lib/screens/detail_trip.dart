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
        appBar: AppBar(title: Text('Поездка')),
        body: Center(
            child: CustomScrollView(slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((context, int i) {
              return Column(children: <Widget>[
                getImageGroup(trip.group),
                Text(trip.route,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                Text(trip.time,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                Text('Количесто мест: ' + trip.seats,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                Text(trip.group,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                Text('Номер телефона: ' + trip.phone,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
                Text(trip.comment,
                    style: TextStyle(fontSize: 30),
                    textAlign: TextAlign.center),
              ]);
            }, childCount: 1),
          )
        ])));
  }
}
