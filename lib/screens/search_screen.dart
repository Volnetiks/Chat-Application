import 'package:chat_application_backend/models/user.dart';
import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:chat_application_backend/widgets/appBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  FirebaseRepository _repository = FirebaseRepository();

  List<User> users;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _repository.getCurrentUser().then((FirebaseUser user) {
      _repository.fetchAllUsers(user).then((List<User> userList) {
        setState(() {
          users = userList;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        gradient: LinearGradient(colors: [Colors.red, Colors.purple]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight + 20),
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: searchController,
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
              cursorColor: Colors.grey,
              autofocus: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 35
              ),
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    searchController.clear();
                  },
                ),
                border: InputBorder.none,
                hintText: "Search...",
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                  color: Colors.white,
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
