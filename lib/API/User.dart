import 'dart:convert';
import 'dart:developer' as developer;
import 'package:http/http.dart' as http;
import 'package:flutter_app/globals.dart' as globals;

class Login {
  final Success success;

  Login({this.success});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      success: Success.fromJson(json["success"]),
    );
  }
}

class Success {
  final String token;

  Success({this.token});

  factory Success.fromJson(Map<String, dynamic> json) {
    return Success(
        token: json['token']
    );
  }
}

Future<void> LoginToken() async {
  developer.log('start', name: 'my.app.category');
  var logintoken = new Login();
  final http.Response response = await http.post(
    'https://innosyssolution.com/api/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "email" : "ggtesffggt@test.com",
      "password" : "111111"
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    logintoken = Login.fromJson(json.decode(response.body));
    developer.log(logintoken.success.token, name: 'my.app.category');
    globals.token = logintoken.success.token;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}