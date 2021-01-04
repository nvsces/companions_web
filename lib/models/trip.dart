class Trip {
  String uid;
  String route;
  String time;
  String seats;
  String phone;
  String group;
  String author;
  String docPath;

  Trip(
      {this.uid,
      this.route,
      this.time,
      this.seats,
      this.phone,
      this.group,
      this.author,
      this.docPath});

  Trip.fromJson(String uid, Map<String, dynamic> data) {
    this.uid = uid;
    route = data['route'];
    time = data['time'];
    seats = data['seats'];
    phone = data['phone'];
    group = data['group'];
    author = data['author'];
    docPath = data['docPath'];
  }

  Map<String, dynamic> toMap() {
    return {
      'route': route,
      'time': time,
      'seats': seats,
      'phone': phone,
      'group': group,
      'author': author,
      'docPath': docPath
    };
  }
}
