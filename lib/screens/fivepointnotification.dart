import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rest/screens/addRestBtn.dart';
import 'package:rest/screens/restaurantOtpVerification.dart';

class FivePointNoti extends StatefulWidget {
  // String restaurantNo;
  // FivePointNoti(this.restaurantNo);
  @override
  _FivePointNotiState createState() => _FivePointNotiState();
}

class _FivePointNotiState extends State<FivePointNoti> {
  FlutterLocalNotificationsPlugin localNotifications;

  Future<void> showInformationsDialogue(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                "Earn 15 more points by verifying restaurant mobile number"),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRestBtn()));
                  },
                  child: Text("skip")),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context,
                        "restOtpVeri",arguments: phNumber );
                  },
                  child: Text("okay")),
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    var androidIntialize = new AndroidInitializationSettings('ic_launcher');

    var initializationSettings =
        new InitializationSettings(android: androidIntialize);
    localNotifications = new FlutterLocalNotificationsPlugin();
    localNotifications.initialize(initializationSettings);

    var androidDetail = new AndroidNotificationDetails(
        "channelId", "Local Notification", "you earned 5 points",
        importance: Importance.high);

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetail);
    localNotifications.show(
        0, "Congrats", "Earned 5 points", generalNotificationDetails);
  }

  // Future _showNotification() async {
  // }

  var phNumber;

  @override
  Widget build(BuildContext context) {
    phNumber = phNumber ?? ModalRoute.of(context).settings.arguments;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showInformationsDialogue(context);
          },
          child: Icon(Icons.arrow_right)),
    );
  }
}
