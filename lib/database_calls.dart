import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';

Future<String> createChatroom(
    String fid, String fname, String sid, String sname) async {
  DocumentReference ref = await firestore.collection('chat_rooms').add({
    'members': [fid, sid]
  });
  await firestore
      .collection('users')
      .doc(fid)
      .collection('contacts')
      .doc(sid)
      .set({
    'contact_name': sname,
    'contact_id': sid,
    'chat_room_id': ref.id,
  });
  await firestore
      .collection('users')
      .doc(sid)
      .collection('contacts')
      .doc(fid)
      .set({
    'contact_name': fname,
    'contact_id': fid,
    'chat_room_id': ref.id,
  });
  return ref.id;
}

Future<String> previouslyPresentInContactList(String contact_doc_id) async {
  DocumentSnapshot contact = await firestore
      .collection('users')
      .doc(user.uid)
      .collection('contacts')
      .doc(contact_doc_id)
      .get();
  if (contact.exists) {
    return contact['chat_room_id'];
  } else {
    return null;
  }
}

Future<QuerySnapshot> getContacts() async {
  return await firestore
      .collection('users')
      .doc(user.uid)
      .collection('contacts')
      .get();
}

sendChat(String chatroomId, String msg) {
  firestore.collection('chat_rooms').doc(chatroomId).collection('chats').add(
      {'msg': msg, 'sender': user.uid, 'time': FieldValue.serverTimestamp()});
}
