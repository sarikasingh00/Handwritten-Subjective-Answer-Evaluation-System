import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:paper_evaluation_app/authentication/user_management.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String _email;
  String _password;
  String _name;
  String _role;
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
            height: MediaQuery.of(context).size.height*0.5,
            width: MediaQuery.of(context).size.width*0.9,
            padding: EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sign Up", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                TextField(
                  decoration: InputDecoration(hintText: 'Name'),
                  onChanged: (value) {
                    setState(() {
                      _name = value;
                      print(_name);
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                      print(_email);
                    });
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  // keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(hintText: 'Password'),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                      print(_password);
                    });
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.9,
                  child: new DropdownButton<String>(isExpanded: true,
                    hint: Text("Role"),
                    value: _role,
                    items: <String>['Teacher', 'Student'].map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: new Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _role = value;
                      });
                      print(_role);
                    },
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  child:
                      _isLoading ? CircularProgressIndicator() : Text("Signup"),
                  elevation: 7.0,
                  onPressed: () {
                    setState(() {
                      _isLoading = true;
                    });
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((signedInUser) {
                      UserManagement().storeNewUser(
                          signedInUser.user, _role, _name, context);
                    }).catchError((e) {
                      print(e);
                    });
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
