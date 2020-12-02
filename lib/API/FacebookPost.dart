import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter_app/globals.dart' as globals;

class FacebookPost {
  final String page_name;
  final String page_photo;
  final String message;
  final String created_time;
  final String picture;
  final String permalink_url;
  FacebookPost({this.page_name, this.page_photo, this.message, this.created_time, this.picture, this.permalink_url});

  factory FacebookPost.fromJson(Map<String, dynamic> json) {
    return FacebookPost(
      page_name: json["page_name"],
      page_photo: json["page_photo"],
      message: json["message"],
      created_time: json["created_time"],
      picture: json["picture"],
      permalink_url: json["permalink_url"]
    );
  }
}

Future<List<FacebookPost>> GetFacebookPost() async {
  developer.log('start GetFacebookPost', name: 'my.app.category');
  final http.Response response = await http.get(
    globals.GetFacebookPostURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );
  if (response.statusCode == 200) {
    List<FacebookPost> AllFacebookPost = List<FacebookPost>.from(json.decode(response.body).map((x) => FacebookPost.fromJson(x)));
    return AllFacebookPost;
  } else {
    throw Exception('Failed to load FacebookPost');
  }
}