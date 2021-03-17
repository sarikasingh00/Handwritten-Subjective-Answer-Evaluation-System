import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StudentDB {
  Future<List<Map<String, String>>> getTeachers() async {
    // FirebaseUser user;
    // await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference subjectsCollection =
        Firestore.instance.collection('users');
    QuerySnapshot users = await subjectsCollection.getDocuments();
    List<Map<String, String>> teacherList = [];
    users.documents.forEach((element) {
      Map<String, dynamic> userDocument = element.data;
      if (userDocument['role'] == 'Teacher') {
        teacherList
            .add({'name': userDocument['name'], 'uid': userDocument['uid']});
      }
      // teacherList.add(element.data());
      // print(element.documentID);
    });
    print(teacherList);
    return teacherList;
  }

  Future<List<String>> getSubjects(String uid) async {
    // FirebaseUser user;
    // await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference subjectsCollection = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('subjects');
    QuerySnapshot subjects = await subjectsCollection.getDocuments();
    List<String> subjectList = [];
    subjects.documents.forEach((element) {
      subjectList.add(element.documentID);
      print(element.documentID);
    });
    return subjectList;
  }

  Future<List<String>> getQuestionPapers(String uid, String subjectName) async {
    // FirebaseUser user;
    // await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference questionPapersCollection = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('subjects')
        .document(subjectName)
        .collection('question_papers');
    QuerySnapshot questionPapers = await questionPapersCollection.getDocuments();
    List<String> questionPapersList = [];
    questionPapers.documents.forEach((element) {
      questionPapersList.add(element.documentID);
      print(element.documentID);
    });
    return questionPapersList;
  }

  Future<List<String>> getQuestions(String uid, String subjectName, String questionPaperName) async {
    // FirebaseUser user;
    // await FirebaseAuth.instance.currentUser().then((value) => user = value);
    CollectionReference questionsCollection = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('subjects')
        .document(subjectName)
        .collection('question_papers')
        .document(questionPaperName)
        .collection('questions');
    QuerySnapshot questions = await questionsCollection.getDocuments();
    List<String> questionsList = [];
    questions.documents.forEach((element) {
      questionsList.add(element.documentID);
      print(element.documentID);
    });
    return questionsList;
  }

  Future<Map<String,dynamic>> getQuestionText(String uid, String subjectName, String questionPaperName, String questionNumber) async {
    // FirebaseUser user;
    // await FirebaseAuth.instance.currentUser().then((value) => user = value);
    DocumentReference questionDocument = Firestore.instance
        .collection('users')
        .document(uid)
        .collection('subjects')
        .document(subjectName)
        .collection('question_papers')
        .document(questionPaperName)
        .collection('questions')
        .document(questionNumber);
    
    Map<String,dynamic> questionText;

    await questionDocument.get().then((doc) {
      // questionText = {'question' : doc.data['question'], 'total_marks':  doc.data['total_marks'].toString(), 'answer': doc.data['answer']};
      questionText = doc.data;
      print(questionText);
    }).catchError((e){
      print("Error getting question text $e");
    });
    print(questionText);
    return questionText;
  }
}
