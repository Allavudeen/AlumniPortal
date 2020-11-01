import 'package:alumni_portal/Models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:alumni_portal/Models/Friends.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  final CollectionReference friendsCollection =
      FirebaseFirestore.instance.collection('Friends');
  Future updateUserData(
      String name,
      String location,
      String whatsapp,
      String mobile,
      String studyyear,
      String permanentaddress,
      String highesteducation) async {
    return await friendsCollection.doc(uid).set({
      'name': name,
      'location': location,
      'whatsapp': whatsapp,
      'mobile': mobile,
      'studyyear': studyyear,
      'permanentaddress': permanentaddress,
      'highesteducation': highesteducation
    });
  }

  // Friends List from Snapshot
  List<Friend> _friendsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Friend(
          name: doc.data()['name'] ?? '',
          location: doc.data()['location'] ?? '',
          whatsapp: doc.data()['whatsapp'] ?? '',
          mobile: doc.data()['mobile'] ?? '',
          studyyear: doc.data()['studyyear'] ?? '',
          permanentaddress: doc.data()['permanentaddress'] ?? '',
          highesteducation: doc.data()['highesteducation'] ?? '');
    }).toList();
  }

  // userData from Snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid.toString(),
        name: snapshot.data()['name'],
        location: snapshot.data()['location'],
        mobile: snapshot.data()['mobile']);
  }

  // get Friends Stream
  Stream<List<Friend>> get friends {
    return friendsCollection.snapshots().map(_friendsListFromSnapshot);
  }

  // get logged-in user doc stream
  Stream<UserData> get userData {
    return friendsCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }
}
