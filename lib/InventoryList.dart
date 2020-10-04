import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'dart:developer' as developer;

class InventoryList extends StatefulWidget {
  final List<Post> ListItems;
  final FirebaseUser user;

  InventoryList(this.ListItems, this.user);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  void like(Function callback){
    setState(() {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.ListItems.length,
      // ignore: missing_return
      itemBuilder: (context, index) {
        var post = this.widget.ListItems[index];
        return Card(
            child: Row(children:
              <Widget>[
                Expanded(
                    child: ListTile(
                    //  leading: Icon(Icons.shopping_cart),
                      title: Text(post.Author),
                      subtitle: Text(post.Body),
                    ),
                ),
                Row(children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: ListTile(
                      title: Text("Qty", style: TextStyle(fontSize: 15)),
                      subtitle: Text("10"),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ListTile(
                      title: Text("Price", style: TextStyle(fontSize: 15)),
                      subtitle: Text("RM " + post.Likes.toString()),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.edit),
                      color: Colors.blue[200],
                      tooltip: "Edit",
                      onPressed: () => {developer.log(globals.token, name: 'my.app.category')}
                  ),
                  IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.blue[200],
                      tooltip: "Delete",
                      onPressed: () => this.like(() => post.LikePost(widget.user))
                  ),
                ])
            ],
          )
        );
      },
    );
  }
}
