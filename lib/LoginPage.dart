import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/API/User.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'RegisterPage.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_app/PushNotification.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        title: Text(tr("login_page")),
        ),
        body: PushNotification(Body()),
      );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;
  TextEditingController NameController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();

  void login(BuildContext context){
    setState(() {
      _isLoading = true;
    });
    LoginToken(NameController.text, PasswordController.text)
        .then((value) =>
        {
          Navigator.pushReplacementNamed(context, "/home"),
          setState(() {
            _isLoading = false;
          })
        })
        .catchError((e) {
          globals.Common.showToast(context, "Login Failed");
          setState(() {
          _isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: this.NameController,
                  decoration: InputDecoration(
                      labelText: 'User Name'
                  ),
                ),
                TextField(
                  controller: this.PasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'User Password'
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: OutlineButton(
                    onPressed: () => this.login(context),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                    splashColor: Colors.red,
                    borderSide: BorderSide(color: Colors.green),
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                            Text("Sign In",
                              style: TextStyle(color: Colors.blue, fontSize: 20))
                        ],
                      ),
                    ),
                  ),
                ),
                OutlineButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => RegisterPage())),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                  splashColor: Colors.red,
                  borderSide: BorderSide(color: Colors.green),
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text("Sign Up",
                          style: TextStyle(color: Colors.blue, fontSize: 20))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isLoading: _isLoading,
        opacity: 0.5,
        progressIndicator: CircularProgressIndicator(),
      ),
    );
  }
}
