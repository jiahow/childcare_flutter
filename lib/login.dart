import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'myhomepage.dart';
import 'auth.dart';
import 'package:flutter_app/API/User.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        title: Text('Login'),
        ),
        body: Body()
      );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  FirebaseUser LoginInUser;
  String name = 'Login';
  TextEditingController controller = new TextEditingController();

  void click(){
    SignInUser().then((user) => {
      LoginToken(),
      this.LoginInUser = user,
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => MyHomePage(title: "Welcome to APP", loginuser: user))),
    }
    );
  }

  Widget GoogleLoginButton() {
    return OutlineButton(
      onPressed: this.click,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
      splashColor: Colors.red,
      borderSide: BorderSide(color: Colors.green),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image(
              image: AssetImage('assets/google_logo.png'),
              height: 35,
            ),
            Padding(padding: EdgeInsets.only(left: 10),
              child:
                Text("Sign In With Google",
                style: TextStyle(color: Colors.blue),)
              ,)
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: this.GoogleLoginButton()
    );
  }
}
