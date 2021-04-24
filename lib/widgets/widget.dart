import 'package:flutter/material.dart';

Widget amberButton({BuildContext context, String label, buttonSize}) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    decoration: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(30),
    ),
    alignment: Alignment.center,
    width: buttonSize != null
        ? buttonSize
        : MediaQuery.of(context).size.width - 48,
    child: Text(
      label,
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
    ),
  );
}

Widget appBar(BuildContext context) {
  return Center(
    child: RichText(
      text: TextSpan(
        style: TextStyle(fontSize: 20),
        children: <TextSpan>[
          TextSpan(
              text: 'R',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.amber)),
        ],
      ),
    ),
  );
}
