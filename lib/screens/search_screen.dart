import 'package:chat_application_backend/models/user.dart';
import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  FirebaseRepository _repository = FirebaseRepository();

  List<User> userList;
  String query = "";
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _repository.getCurrentUser().then((FirebaseUser user) {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
