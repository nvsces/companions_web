import 'dart:html';

import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/services/const.dart';
import 'package:companions_web/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EditTrip extends StatefulWidget {
  final int sectionIndex;
  final Trip initialTrip;

  EditTrip(@required this.sectionIndex, {this.initialTrip, Key key})
      : super(key: key);

  @override
  _EditTripState createState() => _EditTripState();
}

class _EditTripState extends State<EditTrip> {
  final _formKey = GlobalKey<FormBuilderState>();

  Trip trip = Trip();
  myUser user;
  String route;
  String buttonName = "Изменить поездку";

  String getRouteName(int index) {
    switch (index) {
      case 0:
        return 'Пенза-Земетчино';
        break;
      case 1:
        return 'Земетчино-Пенза';
        break;
      case 2:
        return 'Земетчино-Москва';
        break;
      case 3:
        return 'Москва-Земетчино';
        break;
      default:
        return 'Пенза-Земетчино';
    }
  }

  String getRouteString(String routName) {
    switch (routName) {
      case 'Пенза-Земетчино':
        return PenZem;
        break;
      case 'Земетчино-Пенза':
        return ZemPen;
        break;
      case 'Земетчино-Москва':
        return ZemMos;
        break;
      case 'Москва-Земетчино':
        return MosZem;
        break;
      default:
        return ZemPen;
    }
  }

  @override
  void initState() {
    route = getRouteString(widget.initialTrip.route);
    trip = widget.initialTrip;
    super.initState();
  }

  void _saveTrip() async {
    if (trip.phone == null ||
        trip.seats == null ||
        trip.time == null ||
        trip.name == null) {
      print('tost show');
      Fluttertoast.showToast(
          msg: "Заполните все поля",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      await DatabaseService().editTrip(trip, route, widget.initialTrip.docPath);
      Navigator.of(context).pop();
    }
  }

  DateTime stringToDataTime(String time) {
    var dd = int.parse(time.substring(0, 2));
    var mm = int.parse(time.substring(3, 5));
    var yyyy = int.parse(time.substring(6, 10));

    DateTime dataTime = DateTime(yyyy, mm, dd);
    return dataTime;
  }

  String toTime(dynamic data) {
    var timeFormat = data.toString().substring(0, 10);
    var dd = timeFormat.substring(8, 10);
    var mm = timeFormat.substring(5, 7);
    var yyyy = timeFormat.substring(0, 4);
    return "$dd-$mm-$yyyy";
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<myUser>(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Редактирование поездки'),
        ),
        body: CustomScrollView(slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate((context, int i) {
            return Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.white),
                child: FormBuilder(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      Text(
                        getRouteName(widget.sectionIndex),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: FormBuilderDateTimePicker(
                          // onChanged: _onChanged,
                          initialValue:
                              stringToDataTime(widget.initialTrip.time),
                          inputType: InputType.date,
                          format: DateFormat('dd-MM-yyyy'),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Дата поездки',
                          ),
                          onChanged: (dynamic val) {
                            setState(() {
                              trip.time = toTime(val);
                            });
                          },
                          initialTime: TimeOfDay(hour: 8, minute: 0),
                          attribute: '',
                          // initialValue: DateTime.now(),
                          // enabled: true,
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: FormBuilderDropdown(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          attribute: "",
                          initialValue: widget.initialTrip.group,
                          allowClear: false,
                          hint: Text('Группа'),
                          onChanged: (dynamic val) {
                            setState(() {
                              trip.group = val;
                            });
                          },
                          validators: [FormBuilderValidators.required()],
                          items: <String>['Водитель', 'Пассажир']
                              .map((level) => DropdownMenuItem(
                                    value: level,
                                    child: Text('$level'),
                                  ))
                              .toList(),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: FormBuilderTextField(
                          initialValue: widget.initialTrip.name,
                          keyboardType: TextInputType.text,
                          attribute: 'Имя',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Ваше имя",
                          ),
                          onChanged: (dynamic val) {
                            setState(() {
                              trip.name = val;
                            });
                          },
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: FormBuilderTextField(
                          initialValue: widget.initialTrip.phone,
                          keyboardType: TextInputType.phone,
                          attribute: 'Номер телефона',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Номер телефона",
                          ),
                          maxLength: 11,
                          onChanged: (dynamic val) {
                            setState(() {
                              trip.phone = val;
                            });
                          },
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: FormBuilderTextField(
                          initialValue: widget.initialTrip.seats,
                          keyboardType: TextInputType.number,
                          attribute: 'seats',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Количество мест",
                          ),
                          maxLength: 11,
                          onChanged: (dynamic val) {
                            setState(() {
                              trip.seats = val;
                            });
                          },
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.all(10),
                        child: FormBuilderTextField(
                          initialValue: widget.initialTrip.comment,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          attribute: 'comment',
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Комментарий (не обязательно)",
                          ),
                          onChanged: (dynamic val) {
                            setState(() {
                              trip.comment = val;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Text(
                                buttonName,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 15),
                              ),
                              color: Colors.orange,
                              onPressed: () {
                                _saveTrip();
                              }),
                        ),
                      )
                    ])));
          }, childCount: 1))
        ]));
  }
}
