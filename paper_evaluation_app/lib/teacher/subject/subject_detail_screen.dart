import 'package:flutter/material.dart';

import '../question_paper/new_question_paper.dart';
import '../question_paper/question_paper_list.dart';

class SubjectDetailScreen extends StatefulWidget {

  final String subjectName;

  SubjectDetailScreen(this.subjectName);

  @override
  _SubjectDetailScreenState createState() => _SubjectDetailScreenState();
}

class _SubjectDetailScreenState extends State<SubjectDetailScreen> {
  void _startAddNewQuestionPaper(BuildContext ctx, var scaffoldKey) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewQuestionPaper(widget.subjectName,ctx, scaffoldKey),
            // onTap: (){},
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var columnContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.subjectName),),
      body: Container(
        // height: MediaQuery.of(context).size.height*0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   child: Text("Teacher Dashboard"),
            // ),
            Builder(
              builder: (context){ 
                columnContext = context;
                return QuestionPaperListView(widget.subjectName);
                }
            ),
            // List view of subjects under teacher
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _startAddNewQuestionPaper(columnContext, _scaffoldKey);
              }
            )
          ],
        ),
      ),
    );
  }
}
