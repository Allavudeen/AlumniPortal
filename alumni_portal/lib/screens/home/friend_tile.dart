import 'package:flutter/material.dart';
import 'package:alumni_portal/Models/Friends.dart';

class FriendTile extends StatelessWidget {
  final Friend friend;

  FriendTile({this.friend});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blue[300],
          ),
          title: Text(
            'Name: ' + friend.name,
            style: TextStyle(
                color: Colors.blue,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Location: ' +
                friend.location +
                ' Mobile:' +
                friend.mobile +
                '\t WhatsApp:' +
                friend.whatsapp,
            style: TextStyle(color: Colors.green, fontSize: 16.0),
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}
