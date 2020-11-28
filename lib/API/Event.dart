import 'dart:convert';
import 'dart:developer' as developer;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/globals.dart' as globals;

class Event {
  final int id;
  final String title;
  final String body;
  final DateTime date;
  final String type;
  Event({this.id, this.title, this.body, this.date, this.type});

  factory Event.fromJson(Map<String, dynamic> json) {
    DateTime newDate;
    if(json["date"] != null)
      newDate = new DateTime(int.tryParse(json["date"].split("-")[0]),
          int.tryParse(json["date"].split("-")[1]),
          int.tryParse(json["date"].split("-")[2]));
    else
      newDate = new DateTime(int.tryParse(json["start"].split("-")[0]),
          int.tryParse(json["start"].split("-")[1]),
          int.tryParse(json["start"].split("-")[2]));

    return Event(
      id: json["id"],
      title: json["title"],
      body: json["body"],
      date: newDate,
      type: json["type"],
    );
  }
}

Future<List<Event>> GetEvent({String month, String year, String type}) async {
  developer.log('start GetEvent', name: 'my.app.category');
  final http.Response response = await http.post(
    globals.GetEventURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globals.token,
    },
    body: jsonEncode(<String, String>{
      "month" : month??"",
      "year" : year??"",
      "type" : type??"attend"
    }),
  );
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    List<Event> AllEvent = List<Event>.from(result["events"].map((x) => Event.fromJson(x)));
    return AllEvent;
  } else {
    throw Exception('Failed to load Event');
  }
}

Future<Event> CreateEvent({String title, String body, DateTime date, int type}) async {
  developer.log('start CreateEvent', name: 'my.app.category');
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  String formatdate = formatter.format(date);
  final http.Response response = await http.post(
    globals.CreateEventURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globals.token,
    },
    body: jsonEncode(<String, String>{
      "title" : title??"",
      "body" : body??"",
      "date" : formatdate.toString()??DateTime.now().toString(),
      "type" : type.toString()??"1"
    }),
  );
  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    Event event = Event.fromJson(result["event"]);
    return event;
  } else {
    throw Exception('Failed to load Event');
  }
}

Future<bool> DeleteEvent({String id}) async {
  final http.Response response = await http.post(
    globals.DeleteEventURL,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ' + globals.token,
    },
    body: jsonEncode(<String, String>{
      "id" : id??"0",
    }),
  );
  if (response.statusCode == 200) {
    return true;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Event');
  }
}