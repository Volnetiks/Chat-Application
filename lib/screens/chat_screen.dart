import 'package:chat_application_backend/models/user.dart';
import 'package:chat_application_backend/widgets/appBar.dart';
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
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
        title: Text(
          widget.receiver.name
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.phone),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
