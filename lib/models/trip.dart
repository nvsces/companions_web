class Trip {
  String uid;
  String route;
  String time;
  String seats;
  String phone;
  String group;
  String author;
  String vkurl;
  String docPath;
  String name;
  String comment = "";

  Trip(
      {this.uid,
      this.route,
      this.time,
      this.seats,
      this.name,
      this.phone,
      this.group,
      this.author,
      this.vkurl,
      this.docPath,
      this.comment});

  Trip.fromJson(String uid, Map<String, dynamic> data) {
    this.uid = uid;
    route = data['route'];
    time = data['time'];
    seats = data['seats'];
    name = data['name'];
    phone = data['phone'];
    group = data['group'];
    author = data['author'];
    vkurl = data['vkurl'];
    docPath = data['docPath'];
    comment = data['comment'];
  }

  Map<String, dynamic> toMap() {
    return {
      'route': route,
      'time': time,
      'seats': seats,
      'name': name,
      'phone': phone,
      'group': group,
      'author': author,
      'vkurl': vkurl,
      'docPath': docPath,
      'comment': comment
    };
  }
}
