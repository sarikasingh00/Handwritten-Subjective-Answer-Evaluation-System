import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/question_screen.dart';
import 'package:paper_evaluation_app/student/student_db.dart';

class QuestionListScreen extends StatelessWidget {
  String teacherUid;
  String subjectName;
  String questionPaperName;

  QuestionListScreen(this.teacherUid, this.subjectName, this.questionPaperName);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
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
            future: StudentDB()
                .getQuestions(teacherUid, subjectName, questionPaperName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<String> questionList = snapshot.data;
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                      itemCount: questionList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text('${questionList[index]}'),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => QuestionScreen(
                                          teacherUid,
                                          subjectName,
                                          questionPaperName,
                                          questionList[index])));
                            },
                          ),
                        );
                      }),
                );
              } else
                return Container();
            }));
  }
}
