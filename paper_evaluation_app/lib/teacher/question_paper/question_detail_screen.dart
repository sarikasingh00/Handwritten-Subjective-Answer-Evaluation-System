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
                        onPressed: () async{
                          await TeacherDB().addQuestionText(
                              widget.subjectName,
                              widget.questionPaperName,
                              widget.questionNumber,
                              questionController.text,
                              context,
                              scaffoldKey);
                          scaffoldKey.currentState.setState((){});
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
                        onPressed: () async {
                          await TeacherDB().addKeyPhrase(
                              widget.subjectName,
                              widget.questionPaperName,
                              widget.questionNumber,
                              keyphraseController.text,
                              double.parse(keyphraseMarksController.text),
                              context,
                              scaffoldKey);
                          scaffoldKey.currentState.setState((){});
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
    return FutureBuilder(
        future: TeacherDB().getQuestionContent(widget.subjectName,
            widget.questionPaperName, widget.questionNumber),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            Map<String, dynamic> questionContent = snapshot.data;
            return Scaffold(
              backgroundColor: Color(0xFF6F35A5),
                key: _scaffoldKey,
                appBar: AppBar(
                  backgroundColor: Color(0xFF6F35A5),
                  title: Text(widget.questionPaperName),
                ),
                
              // body:Padding(
              //   padding: const EdgeInsets.only(top:60.0),
              //   child: Container(
              //   decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)), color: Colors.white),
              //   height: MediaQuery.of(context).size.height,
              //   width: MediaQuery.of(context).size.width,
              //   child: Padding(
              //     padding: const EdgeInsets.only(top:50.0),
              //     child: Column(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,

              //       children: [
                      
              //         // Text('Question text for ${widget.questionNumber}'),
              //         questionContent.containsKey('question') ? Text(questionContent['question']) : Text('Add a question please'),
              //         questionContent.containsKey('total_marks') ? Text(questionContent['total_marks'].toString()) :Text('Add keyphrases to see total marks'),
              //         questionContent.containsKey('answer') ? Text(questionContent['answer'].toString()) :Text('Add keyphrases'),
                      
              //       ],
              //     ))
              //   ),
              // ),
              body:Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top:18.0),
                        child: SizedBox(
                          height: 30,
                          
                          child: questionContent.containsKey('question') ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              
                              Text(questionContent['question'],style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold,),),
                              SizedBox(width:15),
                              Text(questionContent['total_marks'].toString(),style: TextStyle(color: Colors.white,fontSize:20,fontWeight: FontWeight.bold),),
                            ],
                          ) : Text('Add a question please',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(60), topLeft: Radius.circular(60)), color: Colors.white),
                height: MediaQuery.of(context).size.height-145,
                width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    itemCount: questionContent.length,
                    padding: EdgeInsets.only(top:0),
                    itemBuilder: (context, index) {
                      return Container(
                        // elevation: 5,
                        child: Container(
                          height: 80,
                          child: Container(
                            padding: const EdgeInsets.only(top:50.0),
                            child: ListTile(
                              leading: const Icon(Icons.chevron_right),
                              tileColor: Colors.white,
                              title: Text('${questionContent['answer'].keys.elementAt(index)}'),
							                trailing : Text('${questionContent['answer'][questionContent['answer'].keys.elementAt(index)]}'),
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           QuestionPaperDetailScreen(questionPaperList[index],widget.subjectName)),
                                // );
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                ),
              
                ],
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
                    backgroundColor: Color(0xFF6F35A5),
                    foregroundColor: Colors.white,
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
                        onTap: () =>
                            _startAddQuestionText(context, _scaffoldKey),
                        onLongPress: () => print('Second CHILD LONG PRESS'),
                      ),
                    ]),
    );
          }
        });
  }
}
