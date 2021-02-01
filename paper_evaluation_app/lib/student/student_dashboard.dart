import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import './send_image.dart';
import '../authentication/user_management.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  File _image;
  String _text = "No text";

  Future getImage(bool isCamera) async {
    File image;
    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarTheme.of(context).color,
          title: Text("Student Dashboard"),
          actions: [
            FlatButton(
                onPressed: () {
                  UserManagement().signOut(context);
                },
                child: Text("Sign out", style: Theme.of(context).appBarTheme.textTheme.button,)),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.insert_drive_file),
                onPressed: () {
                  getImage(false);
                },
              ),
              SizedBox(height: 10.0),
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () {
                  getImage(true);
                },
              ),
              _image == null
                  ? Container()
                  : Image.file(
                      _image,
                      height: 300.0,
                      width: 300.0,
                    ),
              RaisedButton(
                  child: Text("Send Image"),
                  onPressed: () {
                    if (_image != null) {
                      SendImage().getExtractedText(_image).then((value) {
                        print("hello $value");
                        setState(() {
                          _text = value;
                          print("in widget tree $_text");
                        });
                      });
                    } else {
                      print("Error");
                    }
                  }),
              Text(_text),
            ],
          ),
        ),
      ),
    );
  }
}
