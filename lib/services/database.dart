import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companions_web/models/trip.dart';
import 'package:companions_web/services/const.dart';

class DatabaseService {
  final CollectionReference _pen_zemCollection =
      FirebaseFirestore.instance.collection(PenZem);
  final CollectionReference _zem_penCollection =
      FirebaseFirestore.instance.collection(ZemPen);
  final CollectionReference _mos_zemCollection =
      FirebaseFirestore.instance.collection(MosZem);
  final CollectionReference _zem_mosCollection =
      FirebaseFirestore.instance.collection(ZemMos);

  CollectionReference _routeCollection;

  CollectionReference _authCollection =
      FirebaseFirestore.instance.collection('AUTH');

  CollectionReference getRouteCollction(String route) {
    switch (route) {
      case PenZem:
        return _pen_zemCollection;
        break;
      case ZemPen:
        return _zem_penCollection;
        break;
      case MosZem:
        return _mos_zemCollection;
        break;
      case ZemMos:
        return _zem_mosCollection;
        break;
      default:
        return _zem_penCollection;
    }
  }

  Future setVkUrl(String authId, String url) async {
    Map<String, dynamic> map = {'vkurl': url};
    return await _authCollection.doc(authId).set(map);
  }

  Future addTrip(Trip trip, String route) async {
    _routeCollection = getRouteCollction(route);
    var _doc = _routeCollection.doc();
    var pathDoc = _doc.id;
    trip.docPath = pathDoc;
    return await _doc.set(trip.toMap());
  }

  String maptoString(Map<String, dynamic> map) {
    return map['vkurl'];
  }

  Stream<String> getVkUrl(String authId) {
    var doc = _authCollection.doc(authId);
    return doc
        .snapshots()
        .map((DocumentSnapshot doc) => maptoString(doc.data()));
  }

  Future editTrip(Trip trip, String route, String docPath) async {
    _routeCollection = getRouteCollction(route);
    var _doc = _routeCollection.doc(docPath);
    trip.docPath = docPath;
    return await _doc.update(trip.toMap());
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
