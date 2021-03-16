import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/student_db.dart';

class QuestionScreen extends StatelessWidget {
  String teacherUid;
  String subjectName;
  String questionPaperName;
  String questionNumber;

  QuestionScreen(this.teacherUid, this.subjectName, this.questionPaperName,
      this.questionNumber);

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Student Dashboard"),
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
                teacherUid, subjectName, questionPaperName, questionNumber),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                Map<String, String> questionText = snapshot.data;
                return Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child: Column(
                      children: [
                        Text(questionText['question']),
                        Text(questionText['total_marks']),
                      ],
                    ));
              } else
                return Container();
            }));
  }
}
