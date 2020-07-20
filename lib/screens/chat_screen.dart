import 'package:chat_application_backend/models/user.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {

  final User receiver;

  ChatScreen({this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
