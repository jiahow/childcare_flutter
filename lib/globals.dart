library my_prj.globals;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/User.dart';

//User Data
String token = "";
User user;

//API
const String BaseURL = "https://innosyssolution.com";
const String LoginURL = BaseURL+"/api/login";
const String RegisterURL = BaseURL+"/api/register";
const String FilterUserURL = BaseURL+"/api/filteruser";
const String GetEventURL = BaseURL+"/api/getevent";
const String CreateEventURL = BaseURL+"/api/createevent";
const String DeleteEventURL = BaseURL+"/api/deleteevent";
const String GetFacebookPostURL = BaseURL+"/api/facebookpost";

class Config {
  static final Map<String, String> langCode = const {
    'en': 'en_US',
    'zh': 'zh_CN'
  };
  static final Map<String, String> Menu = const {
    'User': 'user',
    'TeachMaterial': 'teach_material',
    'Accounting': 'accounting',
    'Calendar': 'calendar',
    'Settings': 'settings',
    'Post': 'facebook_post',
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
