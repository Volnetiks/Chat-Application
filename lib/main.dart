import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:chat_application_backend/screens/home_screen.dart';
import 'package:chat_application_backend/screens/login_screen.dart';
import 'package:chat_application_backend/screens/search_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FirebaseRepository _repository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: "Chat Application",
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        '/search_screen': (context) => SearchScreen()
      },
      home: FutureBuilder(
        future: _repository.getCurrentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if(snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
