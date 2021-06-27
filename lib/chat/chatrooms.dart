import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_recovary_app/chat/chats.dart';
import 'package:health_recovary_app/database_calls.dart';
import 'package:flutter/material.dart';

class Chatrooms extends StatefulWidget {
  @override
  _ChatroomsState createState() => _ChatroomsState();
}

class _ChatroomsState extends State<Chatrooms> {
  QuerySnapshot contacts;
  updateContacts() async {
    contacts = await getContacts();
    //print(contacts.docs[0].data());
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('chats'),
      // ),
      body: Column(
        children: [
          Expanded(
              child: contacts != null && contacts.size != 0
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Chat(
                                            chatRoomId: contacts.docs[index]
                                                ['chat_room_id'],
                                            name: contacts.docs[index]
                                                ['contact_name'],
                                          )));
                            },
                            child: Card(
                              color: Colors.blue.shade200,
                              child: ListTile(
                                // leading: CircleAvatar(
                                //   radius: 25,
                                //   backgroundImage: NetworkImage(
                                //     contacts.docs[index]['contacts_profile'],
                                //   ),
                                // ),
                                title: Text(
                                  contacts.docs[index]['contact_name'],
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.06),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: contacts.size,
                    )
                  : Center(
                      child: Text(
                      "No Contacts Here",
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          letterSpacing:
                              MediaQuery.of(context).size.width * 0.002,
                          fontWeight: FontWeight.bold),
                    )))
        ],
      ),
    );
  }
}
