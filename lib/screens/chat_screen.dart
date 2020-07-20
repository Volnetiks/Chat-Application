import 'package:chat_application_backend/models/message.dart';
import 'package:chat_application_backend/models/user.dart';
import 'package:chat_application_backend/resources/firebase_repository.dart';
import 'package:chat_application_backend/widgets/appBar.dart';
import 'package:chat_application_backend/widgets/customTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final User receiver;

  ChatScreen({this.receiver});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController textFieldController = TextEditingController();
  FirebaseRepository _repository = FirebaseRepository();
  bool isWriting = false;

  User sender;
  String _userId;

  setWriting(bool val) {
    setState(() {
      isWriting = val;
    });
  }

  @override
  void initState() {
    _repository.getCurrentUser().then((FirebaseUser user) {
       _userId = user.uid;

       setState(() {
         sender = User(
           uid: user.uid,
           name: user.displayName,
           profilePhoto: user.photoUrl
         );
       });
    });

    super.initState();
  }

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
        title: Text(widget.receiver.name),
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
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: senderLayout(),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        elevation: 0,
                        backgroundColor: Colors.black,
                        builder: (context) {
                          return Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Row(
                                  children: <Widget>[
                                    FlatButton(
                                      child: Icon(Icons.close),
                                      onPressed: () =>
                                          Navigator.maybePop(context),
                                    ),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Utilities",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: ListView(
                                  children: <Widget>[
                                    ModalTile(
                                      title: "Media",
                                      subtitle: "Share Photos or Video",
                                      icon: Icons.photo,
                                    ),
                                    ModalTile(
                                      title: "Contact",
                                      subtitle: "Share Contacts",
                                      icon: Icons.contacts,
                                    ),
                                    ModalTile(
                                      title: "Location",
                                      subtitle: "Share a location",
                                      icon: Icons.location_on,
                                    ),
                                    ModalTile(
                                      title: "Polls",
                                      subtitle: "Create polls",
                                      icon: Icons.poll,
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.add),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: TextField(
                  controller: textFieldController,
                  style: TextStyle(color: Colors.white),
                  onChanged: (val) {
                    (val.length > 0 && val.trim() != "")
                        ? setWriting(true)
                        : setWriting(false);
                  },
                  decoration: InputDecoration(
                      hintText: "Type a message",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(50)),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child:
                            Icon(Icons.tag_faces, color: Colors.grey.shade900),
                      )),
                )),
                isWriting
                    ? Container(
                        margin: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: Colors.pink, shape: BoxShape.circle),
                        child: IconButton(
                          icon: Icon(Icons.send, size: 15),
                          onPressed: () {
                            sendMessage();
                          },
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(Icons.mic),
                      ),
                isWriting ? Container() : Icon(Icons.camera_alt),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget senderLayout() {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.only(
          topLeft: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Hello",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget receiverLayout() {
    Radius messageRadius = Radius.circular(10);

    return Container(
      margin: EdgeInsets.only(top: 12),
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
      decoration: BoxDecoration(
        color: Colors.grey.shade600,
        borderRadius: BorderRadius.only(
          bottomRight: messageRadius,
          topRight: messageRadius,
          bottomLeft: messageRadius,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Hello",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  sendMessage() {
    var text = textFieldController.text;

    Message _message = Message(
      receiverId: widget.receiver.uid,
      senderId: sender.uid,
      message: text,
      timestamp: FieldValue.serverTimestamp(),
      type: 'text'
    );

    setState(() {
      isWriting = false;
    });

    _repository.addMessageToDatabase(_message, sender, widget.receiver);
  }
}

class ModalTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const ModalTile(
      {@required this.title, @required this.subtitle, @required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: CustomTile(
        mini: false,
        leading: Container(
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.shade800),
          padding: EdgeInsets.all(10),
          child: Icon(
            icon,
            color: Colors.grey,
            size: 38,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
