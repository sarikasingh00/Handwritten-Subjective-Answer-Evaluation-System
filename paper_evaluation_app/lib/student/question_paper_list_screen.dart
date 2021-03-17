import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/question_list_screen.dart';
import 'package:paper_evaluation_app/student/student_db.dart';

class QuestionPaperListScreen extends StatelessWidget {
  
  String teacherUid;
  String subjectName;

  QuestionPaperListScreen(this.teacherUid, this.subjectName);
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
            future: StudentDB().getQuestionPapers(teacherUid, subjectName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<String> questionPaperList = snapshot.data;
                return Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                      itemCount: questionPaperList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 5,
                          child: ListTile(
                            title: Text('${questionPaperList[index]}'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        QuestionListScreen(teacherUid,subjectName,questionPaperList[index])),
                              );
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
