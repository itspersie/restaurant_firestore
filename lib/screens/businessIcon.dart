import 'package:flutter/material.dart';
import 'package:rest/screens/restaurantInfo.dart';

class BussinessIcon extends StatefulWidget {
  @override
  _BussinessIconState createState() => _BussinessIconState();
}

class _BussinessIconState extends State<BussinessIcon> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(child: Text("Press Floating Action Btn")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => RestaurantInfo()));

        },
        child: Icon(Icons.business_rounded),
      ),
    );
  }
}
