import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:chat_application_backend/utils/utils.dart';
import 'package:chat_application_backend/widgets/appBar.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {

  FirebaseRepository _repository = FirebaseRepository();
  String currentUserId, initials;

  @override
  void initState() {
    super.initState();
    _repository.getCurrentUser().then((user) {
      currentUserId = user.uid;
      initials = Utils.getInitials(user.displayName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Icon(
          Icons.notifications,
          color: Colors.white,
        ),
        title: UserCircle(initials),
        centerTitle: true,
        actions: <Widget>[

          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),

          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {},
          ),

        ],
      ),
    );
  }
}

class UserCircle extends StatelessWidget {

  String text;


  UserCircle(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.black,
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.lightBlue,
                fontSize: 13
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.black,
                  width: 2
                ),
                color: Colors.lightGreenAccent
              ),
            ),
          )
        ],
      ),
    );
  }
}
