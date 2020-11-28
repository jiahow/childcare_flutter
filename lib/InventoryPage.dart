import 'package:flutter/cupertino.dart';
import 'package:flutter_app/UI/CustomAppBar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/InventoryList.dart';
import 'package:flutter_app/post.dart';
import 'API/Inventory.dart';
import 'API/User.dart';
import 'package:flutter_app/PushNotification.dart';

class InventoryPage extends StatefulWidget {
  InventoryPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  List<Post> posts = [];
  bool _isLoading = true;

  _InventoryPageState(){
    GetUser();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: widget.title),
        body: PushNotification(LoadingOverlay(
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
                      Expanded( child: InventoryList(posts),
                      ),
                    ],
                  ),
                )
            ),
          isLoading: _isLoading,
          opacity: 0.5,
          progressIndicator: CircularProgressIndicator(),
        ))
    );
  }
}