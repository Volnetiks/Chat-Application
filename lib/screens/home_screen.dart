import 'package:chat_application_backend/screens/pages/ChatListPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller;
  int _page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        children: <Widget>[
          Container(child: ChatListPage()),
          Center(child: Text("Call Logs")),
          Center(
            child: Text("Contact Screen"),
          )
        ],
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.chat,
                    color: (_page == 0) ? Colors.lightBlue : Colors.grey),
                title: Text(
                  "Chats",
                  style: TextStyle(
                      fontSize: 10,
                      color: (_page == 0) ? Colors.lightBlue : Colors.grey),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.call,
                    color: (_page == 1) ? Colors.lightBlue : Colors.grey),
                title: Text(
                  "Call Logs",
                  style: TextStyle(
                      fontSize: 10,
                      color: (_page == 1) ? Colors.lightBlue : Colors.grey),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.contact_phone,
                    color: (_page == 2) ? Colors.lightBlue : Colors.grey),
                title: Text(
                  "Contacts",
                  style: TextStyle(
                      fontSize: 10,
                      color: (_page == 2) ? Colors.lightBlue : Colors.grey),
                ))
          ],
          onTap: navigationTapped,
          currentIndex: _page,
        )
      ),
    );
  }

  void navigationTapped(int page) {
    controller.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
