import 'package:flutter/material.dart';
class SettingDesc extends StatefulWidget {
  @override
  _SettingDescState createState() => _SettingDescState();
}

class _SettingDescState extends State<SettingDesc> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.person),
              title: Text("Profile"),

            ),
          ),

          Card(
            child: ListTile(
              leading: Icon(Icons.lock),
              title: Text("Password"),

            ),

          ),
          Card(
            child: ListTile(
              onTap: (){
                // return LogInAndSignIn().signouts();
              },
              leading: Icon(Icons.exit_to_app),
              title: Text("LogOut"),

            ),

          ),
        ],
      ),
    );
  }
}
