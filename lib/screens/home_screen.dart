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
          Center(
            child: Text("Chat List"),
          ),
          Center(child: Text("Call Logs")),
          Center(
            child: Text("Contact Screen"),
          )
        ],
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
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
          ),
        ),
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }
}
