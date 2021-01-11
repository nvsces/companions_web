import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/detail_trip.dart';
import 'package:companions_web/screens/sidable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

mixin AbsctractList {
  var trips = List<Trip>();

  myUser user;

  loadData();

  void editTrip(Trip trip);
  void deleteTrip(String pathDoc);

  Widget tripInfo(BuildContext context, Trip trip) {
    return Column(children: <Widget>[
      Text(
        trip.route,
        style: TextStyle(fontSize: 1000.0),
      ),
    ]);
  }

  Color getColorGroup(String group) {
    if (group == 'Водитель')
      return Colors.blue;
    else
      return Colors.green;
  }

  Color getColorCard(Trip trip) {
    if (user == null)
      return getColorGroup(trip.group);
    else {
      if (user.id == trip.author)
        return Colors.orange;
      else
        return getColorGroup(trip.group);
    }
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

  Widget buildListTile(BuildContext context, Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => DetailTrip(trip)));
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
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold))
      ]),
    );
  }

  void dismissSlidableItem(SlidableAction action, Trip trip) {
    switch (action) {
      case SlidableAction.delete:
        deleteTrip(trip.docPath);
        break;
      case SlidableAction.edit:
        editTrip(trip);
        break;
      default:
    }
  }

  Widget listCardSlidable(BuildContext context, Trip trip) {
    return Card(
        color: getColorCard(trip),
        child: SlidableWidget(
            onDismissed: (action) => dismissSlidableItem(action, trip),
            child: buildListTile(context, trip)));
  }

  Widget listCard(BuildContext context, Trip trip) {
    return Card(color: getColorCard(trip), child: buildListTile(context, trip));
  }

  Widget getListCard(BuildContext context, Trip trip) {
    if (user == null) return listCard(context, trip);
    if (user.id == trip.author)
      return listCardSlidable(context, trip);
    else
      return listCard(context, trip);
  }

  Widget buildAbsrtactList(BuildContext context) {
    user = Provider.of<myUser>(context);
    return Container(
      child: Container(
        child: ListView.builder(
            itemCount: trips.length,
            itemBuilder: (context, i) {
              return getListCard(context, trips[i]);
            }),
      ),
    );
  }
}
