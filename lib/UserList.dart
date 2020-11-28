import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'API/User.dart';
import 'Model/User.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'dart:developer' as developer;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserList extends StatefulWidget {
  List<User> ListItems;
  String name;
  String role;
  bool _isSearch;
  UserList(this.ListItems, this.name, this.role, this._isSearch);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  int lastrecord = 0;
  int page = 1;

  void _onRefresh() async{
    debugPrint("refresh");
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    widget._isSearch = false;
    debugPrint("Loading");
    page++;
    GetUser(name: widget.name, role: widget.role, page: this.page.toString()).then((UserList) => {
      setState(() {
        UserList.users.forEach((usr) {
          widget.ListItems.add(
              new User(usr.name, usr.email, usr.age, usr.phone_number, usr.address, "", role: usr.role)
          );
        });
        widget._isSearch = true;
        if (UserList.users.length == 0 || UserList.users.length < lastrecord)
          widget._isSearch = false;
        else
          lastrecord = UserList.users.length;
      }),
    });
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: false,
      enablePullUp: widget._isSearch,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Icon(Icons.cloud_download);
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = Icon(Icons.refresh);
          }
          else{
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child:body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
        itemCount: this.widget.ListItems.length,
        itemBuilder: (context, index) {
          var user = this.widget.ListItems[index];
          return Card(
              child: Row(children:
              <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                  ),
                ),
                Row(children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: Text(user.age.toString()),
                  ),
                  SizedBox(
                    width: 60,
                    child: Text(user.phone_number),
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(user.role),
                  ),
                  SizedBox(
                    width: 100,
                    child: Row(
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.edit),
                            color: Colors.blue[200],
                            tooltip: "Edit",
                            onPressed: () => {developer.log(globals.token, name: 'my.app.category')}
                        ),
                        IconButton(
                            icon: Icon(Icons.delete),
                            color: Colors.blue[200],
                            tooltip: "Delete",
                            onPressed: () => {}
                        ),
                      ],
                    )
                  ),
                ])
              ],
              )
          );
        },
      ),
    );
  }
}
