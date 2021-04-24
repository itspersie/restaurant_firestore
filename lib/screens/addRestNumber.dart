import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rest/screens/cameraRestPicture.dart';
import 'package:rest/services/database.dart';

class AddRestNumber extends StatefulWidget {
  @override
  _AddRestNumberState createState() => _AddRestNumberState();
}

class _AddRestNumberState extends State<AddRestNumber> {
  final restPhoneController = TextEditingController();
  DatabaseService databaseService = new DatabaseService();
  Stream restStream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 100,
            ),
            TextFormField(
              validator: (val) => val.isEmpty ? "Enter Phone Number " : null,
              decoration: InputDecoration(
                hintText: " Restaurant Phone Number For Otp Verification",
              ),
              controller: restPhoneController,
            ),

            //SizedBox(height: 20,),

            Spacer(),

            ElevatedButton(
                onPressed: () async {
                  String phoneNumber = restPhoneController.text;
                  Map<String, String> restnumber = {
                    "restaurantPhoneNumber": restPhoneController.text,
                  };
                  var snapshot;
                  await FirebaseFirestore.instance
                      .collection('Restaurant')
                      .doc(restPhoneController.text)
                      .get()
                      .then((value) {
                    snapshot = value.data();
                  });

                  print(snapshot);
                  print(restPhoneController.text);

                  if (snapshot != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Number Already Registered"),
                      ),
                    );
                    print("Exist");
                  }
                  //    ScaffoldMessenger.of(context).showSnackBar(
                  //   SnackBar(
                  //     content: Text("Number Already Exists"),
                  //   ),
                  // )
                  else {
                    Navigator.pushReplacementNamed(context, "cameraScreen",
                        arguments: {
                          "restNumber":restnumber,
                          "phoneNumber":phoneNumber
                        });
                    //   databaseService
                    //       .restaurantPhoneNumber(restnumber, phoneNumber)
                    //       .then((value) {

                    //   });
                  }
                },
                child: Text("Submit")),
          ]),
        ),
      ),
    );
  }
}
