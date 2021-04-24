import 'package:flutter/material.dart';

class ToggleIcon extends StatefulWidget {
  @override
  _ToggleIconState createState() => _ToggleIconState();
}

class _ToggleIconState extends State<ToggleIcon> {
  List<bool> isSelected = [true, false];
  Map data;

  @override
  Widget build(BuildContext context) {
    data = data ?? ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(

        child: Text(data.toString()),

       
      ),
    );
  }
}
