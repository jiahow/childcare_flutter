import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'API/FacebookPost.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'dart:developer' as developer;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FacebookPostList extends StatefulWidget {
  final List<FacebookPost> ListItems;

  FacebookPostList(this.ListItems);

  @override
  _FacebookPostListState createState() => _FacebookPostListState();
}

class _FacebookPostListState extends State<FacebookPostList> {
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
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      Row(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          child:
                          ClipOval(
                            child: Image.network(post.page_photo, height: 60, width: 60,fit: BoxFit.cover,)
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(post.page_name, style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(post.created_time),
                          ),
                        ),
                      ]
                      ),
                      SizedBox(
                        child: ListTile(
                          title: Text(post.message, style: TextStyle( fontSize: 20)),
                          subtitle: (!post.picture.isEmpty)?Image.network(post.picture, height: 250, width: 250):Row(),
                        ),
                      ),
                    ]),
                  ),
                )
              ],
              )
          );
        },
      ),
    );
  }
}
