import 'package:flutter/material.dart';
import 'UI/CustomAppBar.dart';
import 'package:flutter_app/PushNotification.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  String text = "";
  final textcontroller = TextEditingController();

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
      textcontroller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: PushNotification(Center(
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
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}