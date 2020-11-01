import 'package:alumni_portal/Models/user.dart';
import 'package:alumni_portal/services/database.dart';
import 'package:alumni_portal/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:alumni_portal/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentName;
  String _currentLocation;
  String _currentMobile;
  String _currentWhatsapp;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomClassName>(context);

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            UserData userData = snapshot.data;

            return Scaffold(
              resizeToAvoidBottomPadding: false,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Update your Settings',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(height: 20.0),
                      // for Name
                      TextFormField(
                        initialValue: userData.name,
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter Name' : null,
                        onChanged: (val) => setState(() => _currentName = val),
                      ),
                      SizedBox(height: 10.0),
                      //for Location
                      TextFormField(
                        initialValue: userData.location,
                        decoration: TextInputDecoration.copyWith(
                            hintText: 'Present Location'),
                        validator: (val) => val.isEmpty
                            ? 'Please enter Present Location'
                            : null,
                        onChanged: (val) =>
                            setState(() => _currentLocation = val),
                      ),
                      SizedBox(height: 10.0),
                      //for Mobile
                      TextFormField(
                        initialValue: userData.mobile,
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'Mobile'),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter Mobile Number' : null,
                        onChanged: (val) =>
                            setState(() => _currentMobile = val),
                      ),
                      SizedBox(height: 10.0),
                      //for Whatsapp
                      TextFormField(
                        initialValue: userData.mobile,
                        decoration:
                            TextInputDecoration.copyWith(hintText: 'WhatsApp'),
                        validator: (val) =>
                            val.isEmpty ? 'Please enter WhatsApp Number' : null,
                        onChanged: (val) =>
                            setState(() => _currentWhatsapp = val),
                      ),
                      SizedBox(height: 10.0),
                      // for update
                      RaisedButton(
                        color: Colors.pink[400],
                        child: Text(
                          'Update',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          //print(_currentName);
                          //print(_currentLocation);
                          if (_formKey.currentState.validate()) {
                            await DatabaseService(uid: user.uid).updateUserData(
                                _currentName ?? userData.name, // name,
                                _currentLocation ??
                                    userData.location, // location,
                                _currentWhatsapp ??
                                    userData.whatsapp, //whatsapp,
                                _currentMobile ?? userData.mobile, //mobile,
                                '1900-2000', //studyyear,
                                'permanentaddress', //permanentaddress
                                'highesteducation' //highesteducation
                                );
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            print('snapshot returned null');
            return Loading();
          }
        });
  }
}
