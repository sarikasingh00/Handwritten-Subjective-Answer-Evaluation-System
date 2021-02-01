import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../authentication/user_management.dart';
import 'package:flutter/material.dart';

class TeacherDB {
  Future<void> addSubject(
      String name, BuildContext context, var scaffoldKey) async {
    FirebaseUser user;
    await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference subjectsCollection = Firestore.instance
        .collection('users')
        .document(user.uid.toString())
        .collection('subjects');
    await subjectsCollection.document(name).setData({}).then((value) {
      print("Subject added successfully");
      Navigator.of(context).pop();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Subject Added"),
      ));
    }).catchError((e) {
      print("Found error in teacher_db on adding subject\n $e");
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Error Adding Subject"),
      ));
    });
  }

  Future<List<String>> getSubjects() async {
    FirebaseUser user;
    await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference subjectsCollection = Firestore.instance
        .collection('users')
        .document(user.uid.toString())
        .collection('subjects');
    QuerySnapshot qs = await subjectsCollection.getDocuments();
    List<String> subjectList = [];
    qs.documents.forEach((element) {
      subjectList.add(element.documentID);
      print(element.documentID);
    });
    return subjectList;
  }

  Future<void> addQuestionPaper(
      String name, String subjectName,BuildContext context, var scaffoldKey) async {
    FirebaseUser user;
    await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference subjectsCollection = Firestore.instance
        .collection('users')
        .document(user.uid.toString())
        .collection('subjects')
        .document(subjectName).collection('question_papers');
    await subjectsCollection.document(name).setData({}).then((value) {
      print("Question Paper added successfully");
      Navigator.of(context).pop();
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Question Paper added"),
      ));
    }).catchError((e) {
      print("Found error in teacher_db on adding Question Paper\n $e");
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Error Adding Question Paper"),
      ));
    });
  }

  Future<List<String>> getQuestionPapers(String subjectName) async {
    FirebaseUser user;
    await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference subjectsCollection = Firestore.instance
        .collection('users')
        .document(user.uid.toString())
        .collection('subjects')
        .document(subjectName)
        .collection('question_papers');
    QuerySnapshot qs = await subjectsCollection.getDocuments();
    List<String> questionPapertList = [];
    qs.documents.forEach((element) {
      questionPapertList.add(element.documentID);
      print(element.documentID);
    });
    return questionPapertList;
  }
}
