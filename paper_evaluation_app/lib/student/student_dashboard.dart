import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/student/teacher_list.dart';
import '../authentication/user_management.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

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
              child: Text("Sign out", style: Theme.of(context).appBarTheme.textTheme.button,)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TeacherListView(),
          ],
        ),
      ),
    );
  }



  
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     home: Scaffold(
  //       appBar: AppBar(
  //         backgroundColor: AppBarTheme.of(context).color,
  //         title: Text("Student Dashboard"),
  //         actions: [
  //           FlatButton(
  //               onPressed: () {
  //                 UserManagement().signOut(context);
  //               },
  //               child: Text("Sign out", style: Theme.of(context).appBarTheme.textTheme.button,)),
  //         ],
  //       ),
        // body: 
  //     ),
  //   );
  // }
}
