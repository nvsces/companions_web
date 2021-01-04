import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companions_web/models/trip.dart';

class DatabaseService {
  final CollectionReference _pen_zemCollection =
      FirebaseFirestore.instance.collection('Pen_Zem');
  final CollectionReference _zem_penCollection =
      FirebaseFirestore.instance.collection('Zem_Pen');
  final CollectionReference _mos_zemCollection =
      FirebaseFirestore.instance.collection('Mos_Zem');
  final CollectionReference _zem_mosCollection =
      FirebaseFirestore.instance.collection('Zem_Mos');

  CollectionReference _routeCollection;

  CollectionReference getRouteCollction(String route) {
    switch (route) {
      case 'Pen_Zem':
        return _pen_zemCollection;
        break;
      case 'Zem_Pen':
        return _zem_penCollection;
        break;
      case 'Mos_Zem':
        return _mos_zemCollection;
        break;
      case 'Zem_Mos':
        return _zem_mosCollection;
        break;
      default:
        return _zem_penCollection;
    }
  }

  Future addTrip(Trip trip, String route) async {
    _routeCollection = getRouteCollction(route);
    var _doc = _routeCollection.doc();
    var pathDoc = _doc.id;
    trip.docPath = pathDoc;
    return await _doc.set(trip.toMap());
  }

  Future deleteTrip(String pathDoc, String route) async {
    _routeCollection = getRouteCollction(route);
    return await _routeCollection.doc(pathDoc).delete();
  }

  Stream<List<Trip>> getTrips(String route) {
    _routeCollection = getRouteCollction(route);

    return _routeCollection.snapshots().map((QuerySnapshot data) => data.docs
        .map((DocumentSnapshot doc) => Trip.fromJson(doc.id, doc.data()))
        .toList());
  }
}
