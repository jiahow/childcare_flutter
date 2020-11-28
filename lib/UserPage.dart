import 'package:flutter/cupertino.dart';
import 'package:flutter_app/UI/CustomAppBar.dart';
import 'package:flutter_app/UserList.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter/material.dart';
import 'API/User.dart';
import 'Model/User.dart';
import 'package:flutter_app/PushNotification.dart';

class UserPage extends StatefulWidget {
  UserPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  List<User> users = [];
  bool _isLoading = true;
  bool _isVisible = false;
  bool _isSearch = false;
  TextEditingController NameController = new TextEditingController();
  TextEditingController RoleController = new TextEditingController();
  String RoleValue = 'user';

  _UserPageState(){
    GetUser().then((UserList) => {
        setState(() {
          _isLoading = false;
          UserList.users.forEach((usr) {
            this.users.add(
                new User(usr.name, usr.email, usr.age, usr.phone_number, usr.address, "", role: usr.role)
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
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            icon: Icon(Icons.add),
                            color: Colors.blue[200],
                            tooltip: "Add",
                            onPressed: () => {}
                        ),
                      ),
                      OutlineButton(
                        onPressed: () => {
                          setState(() {
                          _isVisible = !_isVisible;
                          })
                        },
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                        splashColor: Colors.lightBlueAccent,
                        borderSide: BorderSide(color: Colors.green),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Icon(Icons.search),
                            ],
                          ),
                        ),
                      ),
                      Visibility (
                        visible: _isVisible,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                              color: Colors.lightBlue,
                              width: 1.0,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                  controller: this.NameController,
                                  decoration: InputDecoration(
                                      labelText: 'Filter Name'
                                  ),
                                ),
                                Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(right: 20),
                                        child: Text("Role", style: TextStyle(fontSize: 15)),
                                      ),
                                      DropdownButton<String>(
                                        value: this.RoleValue,
                                        icon: Icon(Icons.arrow_drop_down),
                                        iconSize: 24,
                                        elevation: 16,
                                        style: TextStyle(color: Colors.black, fontSize: 15),
                                        underline: Container(
                                          height: 2,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            RoleValue = newValue;
                                          });
                                        },
                                        items: <String>['user', 'teacher']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ]
                                ),
                                OutlineButton(
                                  onPressed: () => {
                                    setState(() {
                                      _isVisible = !_isVisible;
                                      _isLoading = true;
                                      _isSearch = true;
                                      GetUser(name: NameController.text, role: RoleController.text).then((UserList) => {
                                        setState(() {
                                          _isLoading = false;
                                          this.users.clear();
                                          UserList.users.forEach((usr) {
                                            this.users.add(
                                                new User(usr.name, usr.email, usr.age, usr.phone_number, usr.address, "", role: usr.role)
                                            );
                                          });
                                        })
                                      });
                                    })
                                  },
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                                  splashColor: Colors.lightBlueAccent,
                                  borderSide: BorderSide(color: Colors.green),
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text("Search"),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ),
                      ),
                      Card(
                          child: Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(children:
                            <Widget>[
                              Expanded(
                                child: Text("Details"),
                              ),
                              Row(children: <Widget>[
                                SizedBox(
                                  width: 60,
                                  child: Text("Age"),
                                ),
                                SizedBox(
                                  width: 60,
                                  child: Text("Address"),
                                ),
                                SizedBox(
                                  width: 40,
                                  child: Text("Role"),
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Center(child: Text("Action")),
                                ),
                              ])
                            ],
                            ),
                          )
                      ),
                      Expanded( child: UserList(users, NameController.text??"", RoleController.text??"", _isSearch),
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