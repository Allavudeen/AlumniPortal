import 'package:alumni_portal/screens/authenticate/authenticate.dart';
import 'package:alumni_portal/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal/Models/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomClassName>(context);

    // return either home or authenticate widget
    //return Home();
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
