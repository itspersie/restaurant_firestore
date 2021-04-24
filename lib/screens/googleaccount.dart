import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rest/screens/addRestBtn.dart';
import 'package:rest/screens/enterphonenumber.dart';
import 'package:rest/widgets/widget.dart';

import 'businessIcon.dart';

class GoogleAccount extends StatefulWidget {
  @override
  _GoogleAccountState createState() => _GoogleAccountState();
}

class _GoogleAccountState extends State<GoogleAccount> {
  final _auth = FirebaseAuth.instance;
  Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    data = data ?? ModalRoute.of(context).settings.arguments;
    print(data.toString()+"  gaccount ");
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width - 40,
          height: 45,
          child: ElevatedButton(
            onPressed: () async {
              final GoogleSignInAccount googleUser =
                  await GoogleSignIn().signIn();

              final GoogleSignInAuthentication googleaAuth =
                  await googleUser.authentication;

              final GoogleAuthCredential credential =
                  GoogleAuthProvider.credential(
                      accessToken: googleaAuth.accessToken,
                      idToken: googleaAuth.idToken);

              await _auth.signInWithCredential(credential).then((value) {
                !data["isOwner"]
                    ? Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => AddRestBtn()))
                    : Navigator.pushReplacementNamed(context, "businessAccount",
                        arguments: data['phoneNumber']);
              });
            },
            child: Text(
              "SignIn",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => EnterPhoneNumber()));
        },
        child: Icon(Icons.logout),
      ),
    );
  }
}
