import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Model/Role.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/globals.dart' as globals;
import 'package:flutter_app/Model/User.dart';

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
  final User user;

  Success({this.token, this.user});

  factory Success.fromJson(Map<String, dynamic> json) {
    return Success(
        token: json['token'],
        user: User.fromJson(json["user"]),
    );
  }
}

Future<bool> Register(String name, String email, String password, String c_password,
    String role, String age, String phone_number, String address) async {
  final http.Response response = await http.post(
    globals.RegisterURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name" : name,
      "email" : email,
      "password" : password,
      "c_password" : c_password,
      "role": role,
      "age" : age,
      "phone_number": phone_number,
      "address": address
    }),
  );
  if (response.statusCode == 200) {
  } else {
    var errorResponse = json.decode(response.body);
    throw Exception(errorResponse['error'][0]);
  }
}


class FilterUserResult {
  final List<User> users;
  final List<Role> roles;
  final Filter filters;

  FilterUserResult({this.users, this.roles, this.filters});
}

class Filter {
  final String role;
  final String name;
  final String status;

  Filter({this.role, this.name, this.status});

  factory Filter.fromJson(Map<String, dynamic> json) {
    return Filter(
      role: json['token'],
      name: json['name'],
      status: json['status'],
    );
  }
}

Future<void> LoginToken(String Name, String Password) async {
  developer.log('start login', name: 'child care');
  final http.Response response = await http.post(
    globals.LoginURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name" : Name,
      "password" : Password
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var result = json.decode(response.body);
    var loginToken = Login.fromJson(result);
    developer.log(loginToken.success.token, name: 'child care');
    globals.token = loginToken.success.token;
    globals.user = loginToken.success.user;
    globals.user.role = result['success']['role'][0]['name'];
    globals.user.access_right = new List();
    var accessright = result['success']['access_right'];
    for(var i = 0; i < accessright.length; i++){
      globals.user.access_right.add(accessright[i]);
    }
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to login');
  }
}


Future<FilterUserResult> GetUser({String name, String role, String page}) async {
  developer.log('start GetUser', name: 'my.app.category');
  final http.Response response = await http.post(
    globals.FilterUserURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globals.token,
    },
    body: jsonEncode(<String, String>{
      "role" : role??"",
      "name" : name??"",
      "page" : page??"1"
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var result = json.decode(response.body);
    List<User> AllUser = List<User>.from(result["users"].map((x) => User.fromJson(x)));
    List<Role> AllRoles = List<Role>.from(result["roles"].map((x) => Role.fromJson(x)));
    Filter AllFilter = Filter.fromJson(result["filter"]);
    FilterUserResult FilterResult = new FilterUserResult(
                                      users: AllUser,
                                      roles: AllRoles,
                                      filters: AllFilter
                                    );
    return FilterResult;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to get User');
  }
}