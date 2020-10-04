import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/database.dart';

class Post {
  String Body;
  String Author;
  int Likes = 0;
  Set UsersLiked = {};
  DatabaseReference _id;

  Post(this.Body, this.Author);

  void LikePost(FirebaseUser user){
    if(this.UsersLiked.contains(user.uid))
      this.UsersLiked.remove(user.uid);
    else
      this.UsersLiked.add(user.uid);

    this.update();
  }

  void update() {
      UpdatePost(this, this._id);
  }

  void SetID (DatabaseReference id){
    this._id = id;
  }

  Map<String, dynamic> ToJSON() {
    return {
      'author': this.Author,
      'body': this.Body,
      'likes': this.Likes,
      'users_liked': this.UsersLiked.toList()
    };
  }
}
