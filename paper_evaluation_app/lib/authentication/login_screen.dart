import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';
import 'package:paper_evaluation_app/components/rounded_button.dart';
import 'package:paper_evaluation_app/components/rounded_input_field.dart';
import 'package:paper_evaluation_app/components/rounded_password_field.dart';

import 'background.dart';
import 'package:flutter_svg/svg.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.03),
              RoundedInputField(
                hintText: "Your Email",
                onChanged: (value) {
                  setState(() {
                      _email = value;
                      print(_email);
                    });
                },
              ),
              RoundedPasswordField(
                onChanged: (value) {
                  setState(() {
                      _password = value;
                      print(_password);
                    });
                },
              ),
              RoundedButton(
                text: "LOGIN",
                press: () {
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
    );
  }
}
