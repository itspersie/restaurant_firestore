import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseService {
  Future<void> restaurantPhoneNumber(

      Map restaurantPhoneNumber, String phoneNumber) async {
        final instance = FirebaseFirestore.instance
        .collection('Restaurant')
        .doc(phoneNumber);

    await instance
        .set({"Verified": false});
      //   instance
      //   .collection("RestInfo")
      //   .add(restaurantPhoneNumber)
      //   .catchError((e) {
      // print("already present");
      // print(e.toString());
      // });

  }

// });
  // Future<void> restaurantPhoneDuplicateVerify(
  //     Map restaurantPhoneNumber, String phoneNumber) async {
  //   await FirebaseFirestore.instance.collection('Restaurant').doc(phoneNumber);
  // }

  Future<void> checkDuplicate(
      Map restaurantPhoneNumber, String phoneNumber) async {
    await FirebaseFirestore.instance.collection('Restaurant').get;
    //.doc(phoneNumber);
  }
}
