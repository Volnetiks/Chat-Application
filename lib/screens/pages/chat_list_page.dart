import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:chat_application_backend/utils/utils.dart';
import 'package:chat_application_backend/widgets/appBar.dart';
import 'package:chat_application_backend/widgets/customTile.dart';
import 'package:flutter/material.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPageState createState() => _ChatListPageState();
}

class _ChatListPageState extends State<ChatListPage> {
  FirebaseRepository _repository = FirebaseRepository();
  String currentUserId;
  String initials = "";

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
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currentUserId),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  final String currentUserId;

  ChatListContainer(this.currentUserId);

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.all(10),
        itemCount: 2,
        itemBuilder: (context, index) {
          return CustomTile(
            mini: false,
            onTap: () {},
            title: Text(
              "Volnetiks",
              style: TextStyle(
                  color: Colors.white, fontFamily: "Arial", fontSize: 19),
            ),
            subtitle: Text(
              "Hello Volnetiks!",
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            leading: Container(
              constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
              child: Stack(
                children: <Widget>[
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.grey,
                    backgroundImage: NetworkImage(
                        "https://www.japanfm.fr/wp-content/uploads/2020/05/Violet-Evergarden-Season-2-Date-de-sortie-prévue-CAST-Intrigue.jpgfit696522ssl1.jpeg"),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: 13,
                      width: 13,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.lightGreen,
                          border: Border.all(color: Colors.black, width: 2)),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
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
                  fontSize: 13),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.black, width: 2),
                  color: Colors.lightGreenAccent),
            ),
          )
        ],
      ),
    );
  }
}
