import 'package:flutter/material.dart';

class RegisterTextField extends StatefulWidget {
  final String Title;
  final TextEditingController TextController;
  RegisterTextField(this.Title, this.TextController);

  @override
  _RegisterTextFieldState createState() => _RegisterTextFieldState();
}

class _RegisterTextFieldState extends State<RegisterTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.TextController,
        decoration: InputDecoration(
            labelText: widget.Title
        ),
        style: TextStyle(
            fontSize: 20.0,
            height: 2.0,
        )
    );
  }
}
