import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'post.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'dart:developer' as developer;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InventoryList extends StatefulWidget {
  final List<Post> ListItems;

  InventoryList(this.ListItems);

  @override
  _InventoryListState createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  void like(Function callback){
    setState(() {
      callback();
    });
  }


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    debugPrint("refresh");
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    debugPrint("Loading");
    setState(() {
      widget.ListItems.add(
          new Post("ddd", "ddd")
      );
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
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: CustomFooter(
        builder: (BuildContext context,LoadStatus mode){
          Widget body ;
          if(mode==LoadStatus.idle){
            body =  Text("pull up load");
          }
          else if(mode==LoadStatus.loading){
            body =  CupertinoActivityIndicator();
          }
          else if(mode == LoadStatus.failed){
            body = Text("Load Failed!Click retry!");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("release to load more");
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
          var post = this.widget.ListItems[index];
          return Card(
              child: Row(children:
              <Widget>[
                Expanded(
                  child: ListTile(
                    title: Text(post.Author),
                    subtitle: Text(post.Body),
                  ),
                ),
                Row(children: <Widget>[
                  SizedBox(
                    width: 60,
                    child: ListTile(
                      title: Text("Qty", style: TextStyle(fontSize: 15)),
                      subtitle: Text("10"),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: ListTile(
                      title: Text("Price", style: TextStyle(fontSize: 15)),
                      subtitle: Text("RM " + post.Likes.toString()),
                    ),
                  ),
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
                ])
              ],
              )
          );
        },
      ),
    );
  }
}
