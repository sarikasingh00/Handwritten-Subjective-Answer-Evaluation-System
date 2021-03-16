import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/teacher/teacher_db.dart';
import './question_list_view.dart';
import './new_question.dart';
import '../question_paper/question_paper_list.dart';

class QuestionPaperDetailScreen extends StatefulWidget {

  final String subjectName;
  final String questionPaperName;

  QuestionPaperDetailScreen(this.questionPaperName, this.subjectName);

  @override
  _QuestionPaperDetailScreenState createState() => _QuestionPaperDetailScreenState();
}

class _QuestionPaperDetailScreenState extends State<QuestionPaperDetailScreen> {
  // void _startAddNewQuestion(BuildContext ctx, var scaffoldKey) {
  //   // showModalBottomSheet(
  //   //     context: ctx,
  //   //     builder: (_) {
  //   //       return GestureDetector(
  //   //         child: NewQuestion(widget.questionPaperName,ctx, scaffoldKey),
  //   //         // onTap: (){},
  //   //         // behavior: HitTestBehavior.opaque,
  //   //       );
  //   //     });
  // }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var columnContext;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.questionPaperName),),
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
                return QuestionListView(widget.subjectName,widget.questionPaperName);
                }
            ),
            // List view of subjects under teacher
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                TeacherDB().addQuestion(widget.subjectName, widget.questionPaperName, context, _scaffoldKey);
                setState(() {
                  
                });
                // _startAddNewQuestion(columnContext, _scaffoldKey);
              }
            )
          ],
        ),
      ),
    );
  }
}