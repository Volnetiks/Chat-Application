import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:chat_application_backend/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text("Login",
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2
        ),),
        onPressed: () => performLogin(),
      )
    );
  }

  void performLogin() {
    _repository.signInWithGoogle().then((FirebaseUser user) {
      if(user != null) {
        _repository.authenticateUser(user).then((isNewUser) {
          if(isNewUser) {
            _repository.addUserToDatabase(user).then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                }
              ));
            });
          } else {
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return HomeScreen();
                }
            ));
          }
        });
      }
    });
  }
}
