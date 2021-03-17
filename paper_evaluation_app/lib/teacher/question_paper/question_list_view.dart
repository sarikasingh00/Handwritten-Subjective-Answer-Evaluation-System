import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/teacher/question_paper/question_detail_screen.dart';
import 'package:paper_evaluation_app/teacher/question_paper/question_paper_detail_screen.dart';
import '../teacher_db.dart';

class QuestionListView extends StatefulWidget {
  final String subjectName;
  final String questionPaperName;

  @override
  _QuestionListViewState createState() => _QuestionListViewState();

  QuestionListView(this.subjectName, this.questionPaperName);
}

class _QuestionListViewState extends State<QuestionListView> {
  @override
  Widget build(BuildContext context) {
    // return Container(child: Text("Question papers of ${widget.subjectName}"));
    return FutureBuilder(
        future: TeacherDB().getQuestions(widget.subjectName, widget.questionPaperName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<String> questionList = snapshot.data;
            questionList.sort();
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: questionList.isEmpty ?Container(height: MediaQuery.of(context).size.height * 0.8, child: Text("No questions"),) :ListView.builder(
                  itemCount: questionList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        tileColor: Color(0xFFF1E6FF),
                        title: Text('${questionList[index]}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    QuestionDetailScreen(widget.subjectName, widget.questionPaperName, questionList[index])),
                          );
                        },
                      ),
                    );
                  }),
            );
          } else
            return Container(height: MediaQuery.of(context).size.height * 0.8,);
        });
  }
}
