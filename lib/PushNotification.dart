import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotification extends StatefulWidget {
  final Widget importPage;
  PushNotification(this.importPage);

  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  String _homeScreenText = "Waiting for token...";
  String _messageText = "Waiting for message...";
  Widget ImportPage;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    print("Notice Start");
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        _messageText = "Push Messaging message: $message";
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        _messageText = "Push Messaging message: $message";
        print("onLaunch: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text('Pay Money'),
              subtitle: Text('Money Money Money MOney'),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onResume: (Map<String, dynamic> message) async {
        _messageText = "Push Messaging message: $message";
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      _homeScreenText = "Push Messaging token: $token";
      print(_homeScreenText);
    });
    _firebaseMessaging.subscribeToTopic('payment');
  }

  @override
  Widget build(BuildContext context) {
    return widget.importPage;
  }
}
