import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) => Card(child: Center(child: Text('1'))),
      itemExtent: 100.0,
      itemCount: 2,
    );
  }
}

// replace this function with the code in the examples
Widget _myListView(BuildContext context) {
  return ListView.builder(
    itemBuilder: (c, i) => Card(child: Center(child: Text('1'))),
    itemExtent: 100.0,
    itemCount: 2,
  );
}

class testPage extends StatefulWidget {
  testPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _testPageState createState() => _testPageState();
}

class _testPageState extends State<testPage> {
  List<String> items = ["1", "2", "3", "4", "5", "6", "7", "8"];
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    debugPrint("refresh");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    debugPrint("Loading");
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    items.add((items.length+1).toString());
    if(mounted)
      setState(() {

      });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return _myListView(context);
  }

}