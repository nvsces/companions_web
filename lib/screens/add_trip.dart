import 'dart:html';

import 'package:companions_web/models/trip.dart';
import 'package:companions_web/models/user.dart';
import 'package:companions_web/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AddTrip extends StatefulWidget {
  final int sectionIndex;

  AddTrip(@required this.sectionIndex, {Key key}) : super(key: key);

  @override
  _AddTripState createState() => _AddTripState();
}

class _AddTripState extends State<AddTrip> {
  final _formKey = GlobalKey<FormBuilderState>();

  Trip trip = Trip();
  myUser user;
  String route;
  String buttonName = "Добавить поездку";

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

  String getRouteString(int index) {
    switch (index) {
      case 0:
        return 'Pen_Zem';
        break;
      case 1:
        return 'Zem_Pen';
        break;
      case 2:
        return 'Zem_Mos';
        break;
      case 3:
        return 'Mos_Zem';
        break;
      default:
        return 'Zem_Pen';
    }
  }

  @override
  void initState() {
    route = getRouteString(widget.sectionIndex);
    trip.group = 'Водитель';
    super.initState();
  }

  void _saveTrip() async {
    if (trip.phone == null || trip.seats == null || trip.time == null) {
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
      if (trip.uid == null) {
        trip.author = user.id;
      }
      trip.route = getRouteName(widget.sectionIndex);
      if (trip.comment == null) trip.comment = '';
      await DatabaseService().addTrip(trip, route);
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
          title: Text('Создание поездки'),
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(color: Colors.white),
            child: FormBuilder(
              key: _formKey,
              child: Column(children: <Widget>[
                Text(
                  getRouteName(widget.sectionIndex),
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                FormBuilderDateTimePicker(
                  // onChanged: _onChanged,
                  inputType: InputType.date,
                  format: DateFormat('dd-MM-yyyy'),
                  decoration: InputDecoration(
                    labelText: 'Дата поездки',
                  ),
                  onChanged: (dynamic val) {
                    setState(() {
                      trip.time = toTime(val);
                    });
                  },
                  initialTime: TimeOfDay(hour: 8, minute: 0), attribute: '',
                  // initialValue: DateTime.now(),
                  // enabled: true,
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.phone,
                  attribute: 'Номер телефона',
                  decoration: InputDecoration(
                    labelText: "Номер телефона",
                  ),
                  maxLength: 11,
                  onChanged: (dynamic val) {
                    setState(() {
                      trip.phone = val;
                    });
                  },
                ),
                FormBuilderDropdown(
                  attribute: "",
                  initialValue: 'Водитель',
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
                FormBuilderTextField(
                  keyboardType: TextInputType.number,
                  attribute: 'seats',
                  decoration: InputDecoration(
                    labelText: "Количество мест",
                  ),
                  maxLength: 11,
                  onChanged: (dynamic val) {
                    setState(() {
                      trip.seats = val;
                    });
                  },
                ),
                FormBuilderTextField(
                  keyboardType: TextInputType.text,
                  attribute: 'comment',
                  decoration: InputDecoration(
                    labelText: "Комментарий (не обязательно)",
                  ),
                  onChanged: (dynamic val) {
                    setState(() {
                      trip.comment = val;
                    });
                  },
                ),
                RaisedButton(
                  splashColor: Theme.of(context).primaryColor,
                  highlightColor: Theme.of(context).primaryColor,
                  color: Colors.white,
                  child: Text(buttonName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 20)),
                  onPressed: () {
                    _saveTrip();
                  },
                )
              ]),
            )));
  }
}
