import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/question_screen.dart';
import 'package:paper_evaluation_app/student/student_db.dart';

class QuestionListScreen extends StatefulWidget {
  String teacherUid;
  String subjectName;
  String questionPaperName;

  QuestionListScreen(this.teacherUid, this.subjectName, this.questionPaperName);

  @override
  _QuestionListScreenState createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
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
            future: StudentDB().getQuestions(widget.teacherUid,
                widget.subjectName, widget.questionPaperName),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<Map<String, bool>> questionList = snapshot.data;
                bool finished =
                    questionList[questionList.length - 1]['finished_attempt'];
                questionList.removeAt(questionList.length - 1);
                return Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.builder(
                          itemCount: questionList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              child: ListTile(
                                title:
                                    Text('${questionList[index].keys.first}'),
                                trailing: questionList[index]
                                        [questionList[index].keys.elementAt(0)]
                                    ? Icon(Icons.assignment_turned_in)
                                    : Icon(Icons.arrow_forward),
                                onTap: () async {
                                  if (finished) {
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        content: Text('Finished attempt')));
                                  } else {
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                QuestionScreen(
                                                    widget.teacherUid,
                                                    widget.subjectName,
                                                    widget.questionPaperName,
                                                    questionList[index]
                                                        .keys
                                                        .first)));
                                    setState(() {});
                                  }
                                },
                              ),
                            );
                          }),
                    ),
                    finished
                        ? FlatButton(
                            onPressed: null, child: Text('Finished Attempt'))
                        : RaisedButton(
                            onPressed: () async {
                                await StudentDB().finishAttempt(
                                    widget.teacherUid,
                                    widget.subjectName,
                                    widget.questionPaperName);
                                setState(() {
                                  
                                });
                            },
                            child: Text('Finish attempt'),
                          )
                  ],
                );
              } else
                return Container();
            }));
  }
}
