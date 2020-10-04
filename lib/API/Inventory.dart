import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter_app/globals.dart' as globals;

class Inventory {
  final int id;
  final int user_id;
  final String title;
  final String body;
  final String created_at;
  final String updated_at;
  Inventory({this.id, this.user_id, this.title, this.body, this.created_at, this.updated_at});

  factory Inventory.fromJson(Map<String, dynamic> json) {
    return Inventory(
      id: json["id"],
      user_id: json["user_id"],
      title: json["title"],
      body: json["body"],
      created_at: json["created_at"],
      updated_at: json["updated_at"],
    );
  }
}

Future<List<Inventory>> GetInventory() async {
  developer.log('start GetInventory', name: 'my.app.category');
  final http.Response response = await http.get(
    'https://innosyssolution.com/api/list',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globals.token,
    },
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    List<Inventory> AllInventory = List<Inventory>.from(json.decode(response.body).map((x) => Inventory.fromJson(x)));
    return AllInventory;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}