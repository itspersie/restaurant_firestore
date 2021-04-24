import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rest/screens/toggleIcon.dart';

class RestaurantInfo extends StatefulWidget {
  @override
  _RestaurantInfoState createState() => _RestaurantInfoState();
}

class _RestaurantInfoState extends State<RestaurantInfo> {
  final ownerNameController = TextEditingController();
  final restaurantNameController = TextEditingController();
  final serviceNameController = TextEditingController();

  String phN;

  Future<void> addData(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection("Restaurant")
        .doc(phN)
        .set(data)
        .whenComplete(() {
      print("path rest");
    });
  }

  @override
  Widget build(BuildContext context) {
    phN = phN ?? ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Owner Name " : null,
              decoration: InputDecoration(
                hintText: "Owner Name",
              ),
              controller: ownerNameController,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Restaurant Name " : null,
              decoration: InputDecoration(
                hintText: "Restaurant Name",
              ),
              controller: restaurantNameController,
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Service Name " : null,
              decoration: InputDecoration(
                hintText: "Service Name",
              ),
              controller: serviceNameController,
            ),
            Spacer(),
            ElevatedButton(
                onPressed: () async {
                  print("adddata before");
                  await addData({
                    "Name": restaurantNameController.text,
                    "Owner": ownerNameController.text,
                    "Service": serviceNameController.text
                  });
                  Navigator.pushNamed(context, "toggleScreen", arguments: {
                    "Name": restaurantNameController.text,
                    "Owner": ownerNameController.text,
                    "Service": serviceNameController.text
                  });
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
