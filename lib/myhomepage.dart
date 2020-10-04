import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/account.dart';
import 'package:flutter_app/database.dart';
import 'post.dart';
import 'postlist.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.loginuser}) : super(key: key);
  final String title;
  final FirebaseUser loginuser;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Post> posts = [];
  int _counter = 0;
  String text = "";
  final textcontroller = TextEditingController();

  void newPost(String text){
    var post = new Post(text, widget.loginuser.displayName);
    post.SetID(SavePost(post));
    setState(() {
      posts.add(new Post(text, widget.loginuser.displayName));
    });
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  void dispose(){
    super.dispose();
    textcontroller.dispose();
  }

  void changeText(text){
    setState(() {
      this.text = text;
    });
  }

  void sendText(){
    setState(() {
      this.text = textcontroller.text;
      newPost(this.text);
      textcontroller.clear();
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':

        break;
      case 'Settings':

        break;
      case 'Accounting':
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AccountPage(title: "Accounting Page", loginuser: widget.loginuser)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Homepage'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings', 'Accounting'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: this.textcontroller,
              decoration: InputDecoration(prefixIcon: Icon(Icons.add_box), labelText: 'Type a message',
                  suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      splashColor: Colors.blue[200],
                      tooltip: "Post Message",
                      onPressed: () => sendText())),
              onChanged: (text) => changeText(text),
            ),
            Text(
                this.text
            ),
            Expanded(child: PostList(posts, widget.loginuser)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}