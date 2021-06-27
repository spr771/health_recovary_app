import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ntp/ntp.dart';
// import 'package:refferencechecker/database_calls.dart';
// import 'package:refferencechecker/validation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

Map<String, dynamic> userDetails;
User user;
final firebase = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;

sign_up(Map<String, dynamic> details, String email, String password) async {
  try {
    var user1 = await firebase.createUserWithEmailAndPassword(
        email: email, password: password);
    details['created_on'] = await NTP.now();
    print(details['first_name']);
    await firestore.collection('users').doc(user1.user.uid).set(details);
    await firebase.signOut();
  } catch (e) {}
}

login(String email, String password) async {
  var user1 = await firebase.signInWithEmailAndPassword(
      email: email, password: password);

  user = user1.user;
  DocumentSnapshot data =
      await firestore.collection('users').doc(user.uid).get();
  userDetails = data.data();
  userDetails['created_on'] = userDetails['created_on'].toDate();
}

logout() async {
  await firebase.signOut();
  userDetails = null;
  user = null;
}

loaduserdata() async {
  if (firebase.currentUser != null) {
    user = firebase.currentUser;
    DocumentSnapshot data =
        await firestore.collection('users').doc(user.uid).get();
    userDetails = data.data();
  }
}
