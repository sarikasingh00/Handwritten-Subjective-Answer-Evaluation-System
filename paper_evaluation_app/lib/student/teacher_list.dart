import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/student/student_db.dart';
import 'package:paper_evaluation_app/student/subject_list_screen.dart';


class TeacherListView extends StatefulWidget {
  @override
  _TeacherListViewState createState() => _TeacherListViewState();
}

class _TeacherListViewState extends State<TeacherListView> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StudentDB().getTeachers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child : CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<Map<String,String>> teacherList = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: teacherList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('${teacherList[index]['name']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SubjectListScreen(teacherList[index]['uid'])),
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