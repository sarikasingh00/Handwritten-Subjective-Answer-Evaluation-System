import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/student/attempted_question_wise_marks.dart';
import 'package:paper_evaluation_app/student/student_db.dart';

class AttemptedPapersScreen extends StatelessWidget {
  String attemptedPaperPath;

  AttemptedPapersScreen(this.attemptedPaperPath);
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF6F35A5),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF6F35A5),
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
        future: StudentDB().getAttemptedPaperQuestions(attemptedPaperPath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            Map<String, dynamic> questionList = snapshot.data;
            var keysList = questionList.keys.toList();
            print(keysList);
            print(questionList);
            // return Column(
            //   children: [
            //     Container(
            //       height: MediaQuery.of(context).size.height * 0.8,
            //       child: ListView.builder(
            //           itemCount: keysList.length,
            //           itemBuilder: (context, index) {
            //             return questionList.keys.elementAt(index) ==
            //                         'finished_attempt' ||
            //                     questionList.keys.elementAt(index) ==
            //                         'total_marks'
            //                 ? Container()
            //                 : Card(
            //                     elevation: 5,
            //                     child: ListTile(
            //                         title: Text(
            //                             '${questionList.keys.elementAt(index)}'),
            //                         trailing: Text(
            //                             '${questionList[keysList[index]].values.elementAt(0)}'),
            //                         onTap: () {
            //                           Navigator.push(
            //                               context,
            //                               MaterialPageRoute(
            //                                   builder: (context) =>
            //                                       AttemptedQuestionWiseMarks(
            //                                           questionList[
            //                                                   keysList[index]]
            //                                               .keys
            //                                               .elementAt(0),
            //                                           questionList[
            //                                                   keysList[index]]
            //                                               .values
            //                                               .elementAt(0).toString())));
            //                         }),
            //                   );
            //           }),
            //     ),
            //     Container(
            //       child: Row(
            //         children: [
            //           Text('Total Marks: '),
            //           Text('${questionList['total_marks']}')
            //         ],
            //       ),
            //     ),
            //   ],
            // );
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)), color: Colors.white),
              height: MediaQuery.of(context).size.height-235,
              child: Padding(
                padding: const EdgeInsets.only(top:50.0),
                child: ListView.builder(
                    itemCount: keysList.length,
                    padding: EdgeInsets.only(top:0),
                    itemBuilder: (context, index) {
                      return questionList.keys.elementAt(index) ==
                                    'finished_attempt' ||
                                questionList.keys.elementAt(index) ==
                                    'total_marks'
                                    ?
                      Container()
                      :
                      Container(
                        // elevation: 5,
                        child: Container(
                          height: 80,
                          child: Container(
                            child: ListTile(
                              leading: const Icon(Icons.auto_stories),
                              tileColor: Colors.white,
                              title: Text(
                                        '${questionList.keys.elementAt(index)}'),
                                    trailing: Text(
                                        '${questionList[keysList[index]].values.elementAt(0)}'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                                  AttemptedQuestionWiseMarks(
                                                      questionList[
                                                              keysList[index]]
                                                          .keys
                                                          .elementAt(0),
                                                      questionList[
                                                              keysList[index]]
                                                          .values
                                                          .elementAt(0).toString()))
                                );
                              },
                            ),  
                          ),
                        ),
                      );
                    }),
              ),
            );
            Container(
                  child: Row(
                    children: [
                      Text('Total Marks: '),
                      Text('${questionList['total_marks']}')
                    ],
                  ),
                );
          } else
            return Container();
        },
      ),
    );
  }
}
