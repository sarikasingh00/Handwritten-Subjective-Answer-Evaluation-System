import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:paper_evaluation_app/teacher/question_paper_list.dart';
import 'package:paper_evaluation_app/teacher/subject/subject_detail_screen.dart';
import '../teacher_db.dart';
// import 'package:paper_evaluation_app/authentication/user_management.dart';
// import '.../authentication/user_management.dart';

class SubjectListView extends StatefulWidget {
  // SubjectListView(){
  //   user = await FirebaseAuth.instance.currentUser();
  // }

  @override
  _SubjectListViewState createState() => _SubjectListViewState();
}

class _SubjectListViewState extends State<SubjectListView> {
  // FirebaseUser user;

  // void initState() async{
  //   super.initState();
  //   user = await UserManagement().getUser();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TeacherDB().getSubjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child : CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<String> subjectList = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: subjectList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      
                      child: ListTile(
                        title: Text('${subjectList[index]}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SubjectDetailScreen(subjectList[index])),
                          );
                        },
                      ),
                    );
                  }),
            );
          } else
            return Container();
        });
  }
}
