import 'package:flutter/material.dart';

class EditAccountPage extends StatefulWidget {
  @override
  _EditAccountPageState createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Account"),
        ),
        body: Container(
          child: Center(
            child: Text("Edit Account"),
          ),
        ),
      ),
    );
  }
}
