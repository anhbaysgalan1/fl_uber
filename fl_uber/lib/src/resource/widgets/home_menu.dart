import 'package:flutter/material.dart';

class HomeMenu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomeMenuState();
  
}

class _HomeMenuState extends State<HomeMenu>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Image.asset("assets/ic_menu_user.png"),
          title: Text("My Profile", style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_history.png"),
          title: Text("Ride History", style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_percent.png"),
          title: Text("Offers", style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_notify.png"),
          title: Text("Notifications", style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_help.png"),
          title: Text("Help & Support", style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
        ),
        ListTile(
          leading: Image.asset("assets/ic_menu_logout.png"),
          title: Text("Logout", style: TextStyle(fontSize: 18, color: Color(0xff323643)),),
        )
      ],
    );
  }
  
}