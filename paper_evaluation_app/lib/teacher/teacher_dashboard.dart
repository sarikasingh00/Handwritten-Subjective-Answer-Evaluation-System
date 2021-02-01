import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/teacher/subject/new_subject.dart';
import 'package:paper_evaluation_app/teacher/subject/subject_list.dart';
import '../authentication/user_management.dart';

class TeacherDashboard extends StatefulWidget {
  @override
  _TeacherDashboardState createState() => _TeacherDashboardState();
}

class _TeacherDashboardState extends State<TeacherDashboard> {
  void _startAddNewSubject(BuildContext ctx, var scaffoldKey) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewSubject(ctx, scaffoldKey),
            // onTap: (){},
            // behavior: HitTestBehavior.opaque,
          );
        });
  }

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Teacher Dashboard"),
        actions: [
          FlatButton(
              onPressed: () {
                UserManagement().signOut(context);
              },
              child: Text("Sign out", style: Theme.of(context).appBarTheme.textTheme.button,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Container(
            //   child: Text("Teacher Dashboard"),
            // ),
            SubjectListView(),
            // List view of subjects under teacher
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _startAddNewSubject(context, _scaffoldKey);
              },
            )
          ],
        ),
      ),
    );
  }
}
