import 'package:flutter/material.dart';
import 'package:rest/screens/enterphonenumber.dart';
import 'package:rest/screens/googleaccount.dart';
import 'package:rest/screens/restaurantOwnerMobileNumber.dart';

class ShareAppLink extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Share App Link")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GoogleAccount()));


        },
        child: Icon(Icons.share),
      ),
    );
  }
}
