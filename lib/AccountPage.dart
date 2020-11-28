import 'package:flutter/material.dart';
import 'UI/AccountButton.dart';
import 'UI/CustomAppBar.dart';
import 'package:flutter_app/PushNotification.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: PushNotification(Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AccountButton("Inventory"),
            AccountButton("Debit"),
            AccountButton("Credit"),
          ],
        ),
      ))
    );
  }
}