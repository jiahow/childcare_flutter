library my_prj.globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/User.dart';

//User Data
String token = "";
User user;

//API
const String LoginURL = "https://innosyssolution.com/api/login";
const String RegisterURL = "https://innosyssolution.com/api/register";
const String FilterUserURL = "https://innosyssolution.com/api/filteruser";
const String GetEventURL = "https://innosyssolution.com/api/getevent";
const String CreateEventURL = "https://innosyssolution.com/api/createevent";
const String DeleteEventURL = "http://innosyssolution.com/api/deleteevent";

class Config {
  static final Map<String, String> langCode = const {
    'en': 'en_US',
    'zh': 'zh_CN'
  };
  static final Map<String, String> Menu = const {
    'User': 'user',
    'TeachMaterial': 'teach_material',
    'Accounting': 'accounting',
    'ChangeLang': 'change_language',
    'Calendar': 'calendar',
    'Settings': 'settings',
    'LogOut': 'logout'
  };
}

class Common {
  // ignore: missing_return
  factory Common.showToast(BuildContext context, String message) {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
      label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}

Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
  Map<String, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[key.toString()] = map[key];
  });
  return newMap;
}

Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
  Map<DateTime, dynamic> newMap = {};
  map.forEach((key, value) {
    newMap[DateTime.parse(key)] = map[key];
  });
  return newMap;
}
