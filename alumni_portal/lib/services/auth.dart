import 'package:alumni_portal/Models/user.dart';
import 'package:alumni_portal/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on FirebaseUser
  CustomClassName _userFromFirebaseUser(User user) {
    return user != null ? CustomClassName(uid: user.uid) : null;
  }

  // auth Change user stream
  /* Stream<CustomClassName> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  } */
  Stream<CustomClassName> get user {
    return _auth
        .authStateChanges()
        .map((User user) => _userFromFirebaseUser(user));
  }

  // Sign In Annonynous
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error Encountered Unfortunately!!!');
      print(e.toString());
      return null;
    }
  }

  // Sign In with Email and Password

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with Email and Password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;

      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData(
          'name',
          'location',
          '5432154321',
          '1234512345',
          '1900-2000',
          'permanentaddress',
          'highesteducation');

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
