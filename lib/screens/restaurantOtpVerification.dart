import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rest/screens/googleaccount.dart';
import 'package:rest/screens/shareapplink.dart';
import 'package:rest/widgets/widget.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

enum MobileVerificationState {
  SHOW_MOBILE_FORM_STATE,
  SHOW_OTP_FORM_STATE,
}

class RestaurantOtpVerification extends StatefulWidget {
  // String restaurantNo;
  // RestaurantOtpVerification(this.restaurantNo);
  @override
  _RestaurantOtpVerificationState createState() =>
      _RestaurantOtpVerificationState();
}

class _RestaurantOtpVerificationState extends State<RestaurantOtpVerification> {
  FlutterLocalNotificationsPlugin localNotifications;
 // final phoneController = TextEditingController();
  final otpController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationId;

  bool _isLoading = false;

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
        0, "Congrats", "Earned 5 more points", generalNotificationDetails);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final authcredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      setState(() {
        _isLoading = false;
      });
      if (authcredential?.user != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShareAppLink()));
      }
    } on Exception catch (e) {
      // TODO

      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  MobileVerificationState currentState =
      MobileVerificationState.SHOW_MOBILE_FORM_STATE;

  getMobileFormWidget(context) {
    return Column(
      children: [
        // TextFormField(
        //   validator: (val) => val.isEmpty ? "Enter Restaurant Number " : null,
        //   decoration: InputDecoration(
        //     hintText: "Restaurant Phone Number For Otp Verification",
        //   ),
        //   controller: phoneController,
        // ),
        Text("$phNumber"),
        //SizedBox(height: 20,),
        Spacer(),
        GestureDetector(
            onTap: () async {
              setState(() {
                _isLoading = true;
              });
              await _auth.verifyPhoneNumber(
                  phoneNumber: phNumber,
                  verificationCompleted: (phoneAuthCredential) async {
                    setState(() {
                      _isLoading = false;
                    });
                    //signInWithPhoneAuthCredential(phoneAuthCredential);
                  },
                  verificationFailed: (verificationFailed) async {
                    setState(() {
                      _isLoading = false;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(verificationFailed.message),
                      ),
                    );
                  },
                  codeSent: (verificationId, resendingToken) async {
                    setState(() {
                      _isLoading = false;
                      currentState =
                          MobileVerificationState.SHOW_OTP_FORM_STATE;
                      this.verificationId = verificationId;
                    });
                  },
                  codeAutoRetrievalTimeout: (verificationId) async {});
            },
            child: amberButton(
              context: context,
              label: "Request OTP",
              //buttonSize: MediaQuery.of(context).size.width/2 - 36,
            )),
      ],
    );
  }

  getOtpFormWidget(context) {
    return Column(
      children: [
        TextFormField(
          validator: (val) => val.isEmpty ? "Enter OTP " : null,
          decoration: InputDecoration(
            hintText: "Enter Otp",
          ),
          controller: otpController,
        ),
        //SizedBox(height: 20,),
        Spacer(),
        GestureDetector(
            onTap: () async {
              PhoneAuthCredential phoneAuthCredential =
                  PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otpController.text);

              signInWithPhoneAuthCredential(phoneAuthCredential);
            },
            child: amberButton(
              context: context,
              label: "Verify",
              //buttonSize: MediaQuery.of(context).size.width/2 - 36,
            )),
      ],
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var phNumber;
  @override
  Widget build(BuildContext context) {
    phNumber = phNumber ?? ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.arrow_right),
      //   onPressed: () {
      //     // Navigator.push(
      //     //     context, MaterialPageRoute(builder: (context) => CreateQuiz()));
      //   },
      // ),
      //

      body: Container(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : currentState == MobileVerificationState.SHOW_MOBILE_FORM_STATE
                ? getMobileFormWidget(context)
                : getOtpFormWidget(context),
        padding: const EdgeInsets.all(16),
      ),
    );
  }
}
