import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/PushNotification.dart';

class RegisterSuccessPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Register Success'),
        ),
        body: PushNotification(Body())
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  _BodyState(){
    Timer timer = new Timer(new Duration(seconds: 5), () {
      //debugPrint("Print after 5 seconds");
      Navigator.pushReplacementNamed(context, "/login");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Register Successfully.", style: TextStyle(fontSize: 30)),
              Text("We will notice when we approve this new account.",textAlign: TextAlign.center, style: TextStyle(fontSize: 30)),
              Text("Thanks!", style: TextStyle(fontSize: 30)),
            ],
          ),
      ),
    );
  }
}
