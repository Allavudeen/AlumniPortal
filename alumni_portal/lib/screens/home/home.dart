import 'package:alumni_portal/Models/Friends.dart';
import 'package:alumni_portal/screens/home/setting_form.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:alumni_portal/services/database.dart';
import 'package:alumni_portal/screens/home/friends_list.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              color: Colors.blue[300],
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Friend>>.value(
      value: DatabaseService().friends,
      child: Scaffold(
        backgroundColor: Colors.blue[200],
        appBar: AppBar(
          title: Text('Friends'),
          backgroundColor: Colors.blue[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Log out'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            FlatButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('Settings'),
            )
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/watercolor-flowers.jpg'),
              fit: BoxFit.cover,
            )),
            child: FriendsList()),
      ),
    );
  }
}
