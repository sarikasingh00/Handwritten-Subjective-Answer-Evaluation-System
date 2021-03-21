import 'package:flutter/material.dart';
import 'package:paper_evaluation_app/student/student_db.dart';
import 'package:paper_evaluation_app/student/subject_list_screen.dart';

import 'attempted_papers_screen.dart';

class AttemptedPapersListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StudentDB().getAttemptedPapers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<Map<String,String>> attemptedPapersLists = snapshot.data;
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView.builder(
                  itemCount: attemptedPapersLists.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 5,
                      child: ListTile(
                        title: Text('${attemptedPapersLists[index]['name']}'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AttemptedPapersScreen(
                                    attemptedPapersLists[index]['path'])),
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
