import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/screens/detail_trip.dart';
import 'package:companions_web/screens/sidable.dart';
import 'package:flutter/material.dart';
import 'package:companions_web/services/const.dart';
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

  int getRouteInSectiomIndex(String route) {
    switch (route) {
      case PenZem:
        return 0;
        break;
      case ZemPen:
        return 1;
        break;
      case ZemMos:
        return 2;
        break;
      case MosZem:
        return 3;
        break;
      default:
        return 0;
    }
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
        elevation: 30,
        //shadowColor: Colors.redAccent,
        margin: EdgeInsets.symmetric(vertical: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: getColorCard(trip),
        child: SlidableWidget(
            onDismissed: (action) => dismissSlidableItem(action, trip),
            child: buildListTile(context, trip)));
  }

  Widget listCard(BuildContext context, Trip trip) {
    return Card(
        elevation: 30,
        //shadowColor: Colors.redAccent,
        margin: EdgeInsets.symmetric(vertical: 7),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: getColorCard(trip),
        child: buildListTile(context, trip));
  }

  Widget getListCard(BuildContext context, Trip trip) {
    if (user == null) return listCard(context, trip);
    if (user.id == trip.author)
      return listCardSlidable(context, trip);
    else
      return listCard(context, trip);
  }

  Widget isData(BuildContext context) {
    if (trips.length > 0) {
      //return Text(trips.length.toString());
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            padding: EdgeInsets.all(20),
            itemCount: trips.length,
            itemBuilder: (context, i) {
              return getListCard(context, trips[i]);
            }),
      );
    } else
      return Center(child: Text('Поездок нет'));
  }

  Widget buildAbsrtactList(BuildContext context) {
    user = Provider.of<myUser>(context);
    return isData(context);
  }
}
