import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TestUrl extends StatelessWidget {
  const TestUrl({Key key}) : super(key: key);

  launchURL() async {
    const url = 'https://vk.com/id510476975';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          launchURL();
        },
        child: Text('Show Flutter homepage'),
      ),
    );
  }
}
