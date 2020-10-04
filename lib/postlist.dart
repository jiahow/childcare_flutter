import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'post.dart';

class PostList extends StatefulWidget {
  final List<Post> ListItems;
  final FirebaseUser user;

  PostList(this.ListItems, this.user);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
        return Card(child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
                title: Text(post.Author),
                subtitle: Text(post.Body),
              )
          ),
          Row(children: <Widget>[
            Container(
              child: Text(post.Likes.toString(),
                  style: TextStyle(fontSize: 20)),
              padding: EdgeInsets.fromLTRB(2, 2, 2, 2),
            ),
            IconButton(
                icon: Icon(Icons.thumb_up),
                color: !post.UsersLiked.contains(widget.user.uid)?Colors.black:Colors.blue[200],
                tooltip: "Post Message",
                onPressed: () => this.like(() => post.LikePost(widget.user)))
          ])
        ],
        ));
      },
    );
  }
}
