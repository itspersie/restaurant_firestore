import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:rest/screens/fivepointnotification.dart';
import 'package:rest/services/database.dart';

class CameraPicture extends StatefulWidget {
  @override
  _CameraPictureState createState() => _CameraPictureState();
}

class _CameraPictureState extends State<CameraPicture> {
  File _image;
  final imagePicker = ImagePicker();
  DatabaseService databaseService = new DatabaseService();
  Map<String, dynamic> data;

  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    data = data ?? ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
          child: Column(
        children: <Widget>[
          SizedBox(
            height: 150,
          ),
          Center(
            child:
                _image == null ? Text("No image selected") : Image.file(_image),
          ),
          Spacer(),
          ElevatedButton(
              onPressed: () {
                databaseService
                    .restaurantPhoneNumber(
                        data["restNumber"], data["phoneNumber"])
                    .then((value) {});

                Navigator.pushReplacementNamed(context, "fivePoint",
                    arguments: data["phoneNumber"]);
              },
              child: Text("Submit")),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        child: Icon(Icons.camera_alt),
      ),
    );
  }
}
