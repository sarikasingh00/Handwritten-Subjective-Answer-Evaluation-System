import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';

class AttemptedQuestionWiseMarks extends StatelessWidget {
  String extractedAnswerText;
  String predictedMarks;

  AttemptedQuestionWiseMarks(this.extractedAnswerText, this.predictedMarks);
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
      body: Container(
        child: Column(
          children: [
            Text('Extracted Text: '),
            Text(
              extractedAnswerText,
            ),
            SizedBox(
              height: 50,
            ),
            Text('Marks Obtained: '),
            Text(predictedMarks),
          ],
        ),
      ),
    );
  }
}
