import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/API/FacebookPost.dart';
import 'package:flutter_app/API/User.dart';
import 'package:flutter_app/AccountPage.dart';
import 'package:flutter_app/CalendarPage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/LoginPage.dart';
import 'package:flutter_app/Portal.dart';
import 'package:flutter_app/UserPage.dart';
import 'package:flutter_app/TeachMaterialPage.dart';
import 'package:flutter_app/globals.dart' as globals;

typedef CallbackLang = Function(String Lang);

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  CallbackLang callback;

  CustomAppBar({Key key, this.title, this.callback}) : preferredSize = Size.fromHeight(kToolbarHeight), super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar>{
  List<String> menuList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    menuList = new List<String>();
    if(globals.user == null)
    {
      menuList.add(tr('login'));
    } else {
      globals.Config.Menu.forEach((key,value){
        switch (key){
          case 'user':
            if(globals.user.access_right.contains("edit-users",)){
              menuList.add(tr(value));
            }
            break;
          default:
            menuList.add(tr(value));
            break;
        }
      });
    }
  }
  void handleClick(String value) {
    if(value == tr('accounting')){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => AccountPage(title: tr("accounting_page"))));
    } else if(value == tr('user')){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserPage(title: tr("user"))));
    } else if(value == tr('teach_material')){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => TeachMaterialPage(title: tr("teach_material"))));
    } else if(value == tr('calendar')){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => CalendarPage(title: tr("calendar"))));
    } else if(value == tr('settings')){

    } else if(value == tr('facebook_post')){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => Portal(title: tr("facebook_post"))));
    } else if(value == tr('login')){
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else if(value == tr('logout')){
      globals.user = null;
      globals.token = "";
      Navigator.pushReplacementNamed(context, "/login");
    } else if(value == tr('change_language')){
      setState(() {
        context.locale = Locale(tr('change_lang'));
        if(widget.callback != null)
          widget.callback(tr('change_lang'));
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        PopupMenuButton<String>(
          onSelected: handleClick,
          itemBuilder: (BuildContext context) {
            return menuList
              .map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: Text(choice),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}