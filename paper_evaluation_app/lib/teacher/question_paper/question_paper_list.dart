import 'package:flutter/material.dart';
import '../teacher_db.dart';

class QuestionPaperListView extends StatefulWidget {
  final String subjectName;

  @override
  _QuestionPaperListViewState createState() => _QuestionPaperListViewState();

  QuestionPaperListView(this.subjectName);
}

class _QuestionPaperListViewState extends State<QuestionPaperListView> {
  @override
  Widget build(BuildContext context) {
    // return Container(child: Text("Question papers of ${widget.subjectName}"));
    return FutureBuilder(
        future: TeacherDB().getQuestionPapers(widget.subjectName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasData) {
            List<String> questionPaperList = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: questionPaperList.isEmpty ?Container(height: MediaQuery.of(context).size.height * 0.8, child: Text("No question papers"),) :ListView.builder(
                  itemCount: questionPaperList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('${questionPaperList[index]}'),
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             SubjectDetailScreen(questionPaperList[index])),
                        //   );
                        // },
                      ),
                    );
                  }),
            );
          } else
            return Container(height: MediaQuery.of(context).size.height * 0.8,);
        });
  }
}
