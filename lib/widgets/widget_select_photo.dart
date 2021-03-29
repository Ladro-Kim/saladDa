import 'package:flutter/material.dart';

class SelectPhotoWidget extends StatefulWidget {
  @override
  _SelectPhotoWidgetState createState() => _SelectPhotoWidgetState();
}

class _SelectPhotoWidgetState extends State<SelectPhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text("Select photo (Click)"),),
    );
  }
}
