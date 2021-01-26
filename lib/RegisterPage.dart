import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/API/User.dart';
import 'package:flutter_app/globals.dart' as globals;
import 'package:flutter_app/UI/RegisterTextField.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:flutter_app/PushNotification.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        title: Text('Register'),
        ),
        body: PushNotification(Body())
      );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoading = false;
  String name = 'Register';
  TextEditingController NameController = new TextEditingController();
  TextEditingController PasswordController = new TextEditingController();
  TextEditingController ConfirmPasswordController = new TextEditingController();
  TextEditingController EmailController = new TextEditingController();
  TextEditingController AgeController = new TextEditingController();
  TextEditingController PhoneNumberController = new TextEditingController();
  TextEditingController AddressController = new TextEditingController();

  String RoleValue = 'user';

  void register(BuildContext context){
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(EmailController.text);
    if(!emailValid)
    {
      globals.Common.showToast(context, "Invalid email format.");
      return;
    }
    setState(() {
      _isLoading = true;
    });
    Register(this.NameController.text, this.EmailController.text, this.PasswordController.text, this.ConfirmPasswordController.text,
        this.RoleValue, this.AgeController.text, this.PhoneNumberController.text, this.AddressController.text)
        .then((value) =>
        {
          Navigator.pushReplacementNamed(context, "/registerSuccess"),
          setState(() {
            _isLoading = true;
          })
        })
        .catchError((e) {
          globals.Common.showToast(context, "Register Failed");
          setState(() {
            _isLoading = false;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingOverlay(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RegisterTextField('User Name', this.NameController),
                TextField(
                  controller: this.PasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'User Password'
                  ),
                ),
                TextField(
                  controller: this.ConfirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Confirm Password'
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text("Role", style: TextStyle(fontSize: 20)),
                        ),
                        DropdownButton<String>(
                          value: this.RoleValue,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 20),
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
                ),
                TextField(
                  controller: this.AgeController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                  decoration: InputDecoration(
                      labelText: 'Age'
                  ),
                  style: TextStyle(
                      fontSize: 20.0,
                      height: 2.0,
                  ),
                ),
                RegisterTextField('Phone Number', this.PhoneNumberController),
                RegisterTextField('Email', this.EmailController),
                RegisterTextField('Address', this.AddressController),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: OutlineButton(
                    onPressed: () => this.register(context),
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
