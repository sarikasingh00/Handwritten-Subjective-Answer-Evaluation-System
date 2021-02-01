import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email;
  String _password;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Card(
          elevation: 5,
          shadowColor: Colors.grey,
          child: Container(
            height: MediaQuery.of(context).size.height*0.4,
            width: MediaQuery.of(context).size.width*0.9,
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Login", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      hintText: 'Email',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                      print(_email);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  obscureText: true,
                  // keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red))),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      print(_password);
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                RaisedButton(
                  // color: Colors.limeAccent,
                  child:
                      _isLoading ? CircularProgressIndicator() : Text("Login"),
                  elevation: 7.0,
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                      email: _email,
                      password: _password,
                    )
                        .catchError((e) {
                      print(e);
                    }).then((authUser) {
                      var user = authUser.user;
                      UserManagement().getUserRole(user).then((userRole) {
                        print("user role from func = $userRole");
                        if (userRole == 'Teacher') {
                          Navigator.of(context)
                              .pushReplacementNamed('/teacher_dashboard');
                          print('Hello Teacher');
                        } else
                          Navigator.of(context)
                              .pushReplacementNamed('/student_dashboard');
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  child: Text("Don't have an account? Sign up here!"),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/signuppage');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
