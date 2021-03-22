import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/send_image.dart';
import 'package:paper_evaluation_app/student/student_db.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class QuestionScreen extends StatefulWidget {
  String teacherUid;
  String subjectName;
  String questionPaperName;
  String questionNumber;

  QuestionScreen(this.teacherUid, this.subjectName, this.questionPaperName,
      this.questionNumber);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    return Scaffold(
        backgroundColor: Colors.red,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Student Dashboard"),
          backgroundColor: Color(0xFF6F35A5),
          actions: [
            FlatButton(
                onPressed: () {
                  UserManagement().signOut(context);
                },
                child: Text(
                  "Sign out",
                  style: Theme.of(context).appBarTheme.textTheme.button,
                )),
          ],
        ),
        body: FutureBuilder(
            future: StudentDB().getQuestionText(
                widget.teacherUid,
                widget.subjectName,
                widget.questionPaperName,
                widget.questionNumber),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                Map<String, dynamic> questionText = snapshot.data;
                return Column(
                  children: [
                    Container(
                      //height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        children: [
                          questionText.containsKey('question')?Text(questionText['question']): Text('No question text added yet, please contact your Teacher'),
                          questionText.containsKey('question') ? Text(questionText['total_marks'].toString()):  Text(''),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
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
                                    SendImage()
                                        .getExtractedText(_image, questionText['answer'].toString())
                                        .then((value) {
                                      print("hello $value");
                                      setState(() {
                                        _text = "Answer recordded!";
                                        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Answer recorded'),));
                                        print(value);
                                      });
                                      StudentDB().addAnswer(widget.teacherUid, widget.subjectName, widget.questionPaperName, widget.questionNumber, value['text'], value['marks']);
                                    });
                                  } else {
                                    print("Error");
                                  }
                                }),
                            // Text(_text),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else
                return Container();
            }));
  }
}
