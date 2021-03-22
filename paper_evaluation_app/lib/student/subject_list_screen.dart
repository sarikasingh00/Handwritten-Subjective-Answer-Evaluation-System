import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/question_paper_list_screen.dart';
import 'package:paper_evaluation_app/student/student_db.dart';

class SubjectListScreen extends StatelessWidget {
  String teacherUid;

  SubjectListScreen(this.teacherUid);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF6F35A5),
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
            future: StudentDB().getSubjects(teacherUid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData) {
                List<String> subjectList = snapshot.data;
                // return Container(
                //   height: MediaQuery.of(context).size.height * 0.8,
                //   child: ListView.builder(
                //       itemCount: subjectList.length,
                //       itemBuilder: (context, index) {
                //         return Card(
                //           elevation: 5,
                //           child: ListTile(
                //             title: Text('${subjectList[index]}'),
                //             onTap: () {
                //               Navigator.push(
                //                 context,
                //                 MaterialPageRoute(
                //                     builder: (context) =>
                //                         QuestionPaperListScreen(teacherUid,subjectList[index])),
                //               );
                //             },
                //           ),
                //         );
                //       }),
                // );
                return Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)), color: Colors.white),
                height: MediaQuery.of(context).size.height-200,
                child: Padding(
                  padding: const EdgeInsets.only(top:50.0),
                  child: ListView.builder(
                      itemCount: subjectList.length,
                      padding: EdgeInsets.only(top:0),
                      itemBuilder: (context, index) {
                        return Container(
                          // elevation: 5,
                          child: Container(
                            height: 80,
                            child: Container(
                              child: ListTile(
                                leading: const Icon(Icons.auto_stories),
                                tileColor: Colors.white,
                                title: Text('${subjectList[index]}'),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        QuestionPaperListScreen(teacherUid,subjectList[index])),
                                  );
                                },
                              ),  
                            ),
                          ),
                        );
                      }),
                ),
              );
              } else
                return Container();
            }));
  }
}

class QuestionPaperList {
}
