import 'package:alumni_portal/Models/Friends.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:alumni_portal/screens/home/friend_tile.dart';

class FriendsList extends StatefulWidget {
  @override
  _FriendsListState createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  @override
  Widget build(BuildContext context) {
    final friends = Provider.of<List<Friend>>(context) ?? [];

    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        print('Length is:');
        print(friends.length);
        return FriendTile(friend: friends[index]);
      },
    );
  }
}
