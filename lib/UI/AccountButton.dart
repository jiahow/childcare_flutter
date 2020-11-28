import 'package:flutter/material.dart';
import '../InventoryPage.dart';

class AccountButton extends StatefulWidget {
  final String Title;
  AccountButton(this.Title);

  @override
  _AccountButtonState createState() => _AccountButtonState();
}

class _AccountButtonState extends State<AccountButton> {
  void handleClick(String value) {
    switch (value) {
      case 'Inventory':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => InventoryPage(title: value)));
        break;
      case 'Debit':
        break;
      case 'Credit':
        break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: OutlineButton(
        onPressed: () => handleClick(widget.Title),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
        borderSide: BorderSide(color: Colors.blueAccent),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.Title,
                style: TextStyle(color: Colors.grey, fontSize: 20),)
            ],
          ),
        ),
      ),
    );
  }
}
