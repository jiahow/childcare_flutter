import 'package:flutter/cupertino.dart';
import 'package:flutter_app/UI/CustomAppBar.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/FacebookPostList.dart';
import 'API/FacebookPost.dart';
import 'API/User.dart';
import 'package:flutter_app/PushNotification.dart';

class Portal extends StatefulWidget {
  Portal({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _PortalState createState() => _PortalState();
}

class _PortalState extends State<Portal> {
  List<FacebookPost> posts = [];
  bool _isLoading = true;

  _PortalState(){
    GetUser();
    GetFacebookPost().then((PostList) => {
      setState(() {
        _isLoading = false;
        PostList.forEach((Post) {
          this.posts.add(
              new FacebookPost(
                  page_name: Post.page_name, page_photo: Post.page_photo,
                  message:Post.message, created_time: Post.created_time, picture: Post.picture, permalink_url: Post.permalink_url)
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
                    Expanded( child: FacebookPostList(posts),
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