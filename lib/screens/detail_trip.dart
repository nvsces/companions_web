import 'package:companions_web/models/trip.dart';
import 'package:flutter/material.dart';

class DetailTrip extends StatelessWidget {
  final Trip trip;

  const DetailTrip(@required this.trip, {Key key}) : super(key: key);

  Widget getImageGroup(String group) {
    if (group == 'Водитель')
      return Image.asset(
        'assets/images/driver.jpg',
        scale: 2,
      );
    else
      return Image.asset(
        'assets/images/pas.jpg',
        scale: 3,
      );
  }

  Widget _buildBody(BuildContext context, Trip trip) {
    return ListView(
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Маршрут',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(trip.route),
                Text(
                  'Дата поездки',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(trip.time),
                Text(
                  'Количество мест: ' + trip.seats,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      trip.group,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(trip.name),
                    Text(
                      'Номер телефона',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(trip.phone)
                  ],
                ),
                getImageGroup(trip.group)
              ],
            ),
          ),
        ),
        if (trip.comment.isNotEmpty)
          Card(
              child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Комментарий',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(trip.comment),
              ],
            ),
          )),
        Padding(
          padding: EdgeInsets.all(5),
          child: RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Text(
                'Вернуться назад',
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
              color: Colors.white,
              onPressed: () {
                Navigator.pop(context);
              }),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text(
            'Поездка',
            style: TextStyle(color: Colors.white, fontFamily: "NotoSansJP"),
          ),
          elevation: 0,
          backgroundColor: Colors.white.withOpacity(0),
        ),
        body: _buildBody(context, trip)
        //  Center(
        //     child: CustomScrollView(slivers: <Widget>[
        //   SliverList(
        //     delegate: SliverChildBuilderDelegate((context, int i) {
        // //       return Container(
        //         decoration: BoxDecoration(
        //           color: Colors.orange,
        //           borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(20),
        //               topRight: Radius.circular(20)),
        //         ),
        //         child: Column(children: <Widget>[
        //           getImageGroup(trip.group),
        //           Text(trip.route,
        //               style: TextStyle(
        //                 fontSize: 30,
        //               ),
        //               textAlign: TextAlign.center),
        //           Text(trip.time,
        //               style: TextStyle(
        //                 fontSize: 30,
        //               ),
        //               textAlign: TextAlign.center),
        //           Text('Количесто мест: ' + trip.seats,
        //               style: TextStyle(
        //                 fontSize: 30,
        //               ),
        //               textAlign: TextAlign.center),
        //           Text(trip.group,
        //               style: TextStyle(
        //                 fontSize: 30,
        //               ),
        //               textAlign: TextAlign.center),
        //           Text('Номер телефона: ' + trip.phone,
        //               style: TextStyle(
        //                 fontSize: 30,
        //               ),
        //               textAlign: TextAlign.center),
        //           Text(trip.comment,
        //               style: TextStyle(
        //                 fontSize: 20,
        //               ),
        //               textAlign: TextAlign.center),
        //         ]),
        //       );
        //     }, childCount: 1),
        //   )
        // ]))
        );
  }
}
