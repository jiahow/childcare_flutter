import 'package:firebase_auth/firebase_auth.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/InventoryList.dart';
import 'post.dart';
import 'API/Inventory.dart';

class InventoryPage extends StatefulWidget {
  InventoryPage({Key key, this.title, this.loginuser}) : super(key: key);
  final String title;
  final FirebaseUser loginuser;
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Post> posts = [];
  bool _isLoading = true;

  _InventoryPageState(){
    GetInventory().then((InvList) => {
        setState(() {
          _isLoading = false;
          InvList.forEach((Inv) {
            this.posts.add(
                new Post(Inv.body, Inv.title)
            );
        });
      })
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: handleClick,
              itemBuilder: (BuildContext context) {
                return {'Logout', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body:
        LoadingOverlay(
            child: Container(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.blue[200],
                            tooltip: "Add",
                            onPressed: () => {}
                        ),
                      ),
                      Expanded(child: InventoryList(posts, widget.loginuser)),
                    ],
                  ),
                )
            ),
          isLoading: _isLoading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        )

    );
  }
}