import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:paper_evaluation_app/teacher/teacher_db.dart';

class QuestionDetailScreen extends StatefulWidget {
  String subjectName;
  String questionPaperName;
  String questionNumber;

  QuestionDetailScreen(
      this.subjectName, this.questionPaperName, this.questionNumber);

  @override
  _QuestionDetailScreenState createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  final questionController = TextEditingController();
  final keyphraseController = TextEditingController();
  final keyphraseMarksController = TextEditingController();

  void _startAddQuestionText(BuildContext ctx, var scaffoldKey) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Question Text'),
                      controller: questionController,
                      // onSubmitted: (_) => __submitData(),
                    ),
                    RaisedButton(
                        onPressed: () {
                          TeacherDB().addQuestionText(widget.subjectName, widget.questionPaperName, widget.questionNumber, questionController.text, context, scaffoldKey);
                        },
                        child: Text(
                          'Add Question',
                        ),
                        color: Theme.of(context).buttonColor,
                        textColor: Theme.of(context).textTheme.button.color),
                  ],
                ),
              ),
            ),
          ));
          // onTap: (){},
          // behavior: HitTestBehavior.opaque,
        });
  }

  void _startAddKeyPhrase(BuildContext ctx, var scaffoldKey) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: SingleChildScrollView(
            child: Card(
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: MediaQuery.of(context).viewInsets.bottom + 10),
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Keyphrase text'),
                      controller: keyphraseController,
                      // onSubmitted: (_) => __submitData(),
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Keyphrase marks'),
                      controller: keyphraseMarksController,
                      keyboardType: TextInputType.number,
                      // onSubmitted: (_) => __submitData(),
                    ),
                    RaisedButton(
                        onPressed: () {
                          TeacherDB().addKeyPhrase(widget.subjectName, widget.questionPaperName, widget.questionNumber, keyphraseController.text, double.parse(keyphraseMarksController.text) ,context, scaffoldKey);
                        },
                        child: Text(
                          'Add Keyphrase',
                        ),
                        color: Theme.of(context).buttonColor,
                        textColor: Theme.of(context).textTheme.button.color),
                  ],
                ),
              ),
            ),
          ));
          // onTap: (){},
          // behavior: HitTestBehavior.opaque,
        });
  }



  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF6F35A5),
          title: Text(widget.questionPaperName),
        ),
        floatingActionButton: SpeedDial(
            marginEnd: 18,
            marginBottom: 20,
            icon: Icons.add,
            activeIcon: Icons.remove,
            visible: true,

            /// If true user is forced to close dial manually
            /// by tapping main button and overlay is not rendered.
            closeManually: false,

            /// If true overlay will render no matter what.
            renderOverlay: false,
            curve: Curves.bounceIn,
            overlayColor: Colors.black,
            overlayOpacity: 0.5,
            onOpen: () => print('OPENING DIAL'),
            onClose: () => print('DIAL CLOSED'),
            tooltip: 'Speed Dial',
            heroTag: 'speed-dial-hero-tag',
            backgroundColor: Colors.blue,
            foregroundColor: Colors.black,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                labelBackgroundColor: Colors.white,
                child: Icon(Icons.question_answer),
                backgroundColor: Colors.greenAccent,
                label: 'Add Key Phrase',
                // labelStyle: TextStyle(fontSize: 18.0,),
                onTap: () => _startAddKeyPhrase(context, _scaffoldKey),
                    // print('FIRST CHILD'), //change to add phrase modal function
                onLongPress: () => print('FIRST CHILD LONG PRESS'),
              ),
              SpeedDialChild(
                labelBackgroundColor: Colors.white,
                child: Icon(Icons.question_answer),
                backgroundColor: Colors.red,
                label: 'Add/Edit Question',
                // labelStyle: TextStyle(fontSize: 18.0),
                onTap: () => _startAddQuestionText(context, _scaffoldKey),
                onLongPress: () => print('Second CHILD LONG PRESS'),
              ),
            ]),
        body: Container(
            // height: MediaQuery.of(context).size.height*0.8,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Question text for ${widget.questionNumber}'),
            Text('Total marks'),
            Text('List of answers'),
            Text('modal to question'),
            Text('modal to add a new keyphrase')
          ],
        )));
  }
}
