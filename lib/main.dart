import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rest/screens/businessIcon.dart';
import 'package:rest/screens/enterphonenumber.dart';
import 'package:rest/screens/fivepointnotification.dart';
import 'package:rest/screens/googleaccount.dart';
import 'package:rest/screens/restaurantOtpVerification.dart';
import 'package:rest/screens/toggleIcon.dart';

import './screens/cameraRestPicture.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: InitializerWidget(),
      routes: {
        "cameraScreen":(context)=>CameraPicture(),
        "fivePoint": (context) => FivePointNoti(),
        "restOtpVeri":(context) => RestaurantOtpVerification(),
        "googleAccount":(context) => GoogleAccount(),
        "businessAccount":(context) => BussinessIcon(),
        "toggleScreen":(context) => ToggleIcon(),
      },
    );
  }
}

class InitializerWidget extends StatefulWidget {
  @override
  _InitializerWidgetState createState() => _InitializerWidgetState();
}

class _InitializerWidgetState extends State<InitializerWidget> {
  FirebaseAuth _auth;

  User _user;

  bool isloading = true;

  @override
  void initState() {
    // TODO: implement initState
    _auth = FirebaseAuth.instance;
    _user = _auth.currentUser;
    isloading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isloading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : _user == null
            ? EnterPhoneNumber()
            : GoogleAccount();
  }
}
