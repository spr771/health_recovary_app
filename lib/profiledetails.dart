import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/chat/chats.dart';
import 'package:health_recovary_app/database_calls.dart';
import 'package:intl/intl.dart';

class profile extends StatefulWidget {
  String id;
  String name;
  profile({this.id, this.name});

  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  QuerySnapshot posts;
  getposts() async {
    posts = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.id)
        .collection("posts")
        .orderBy('postTime', descending: true)
        .get();
    setState(() {
      posts = posts;
      print(posts.size);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getposts();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print(userDetails['first_name']);
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          heroTag: 1,
          child: Icon(
            Icons.chat,
            size: 30,
          ),
          onPressed: () async {
            String chatRoomId = await previouslyPresentInContactList(widget.id);

            if (chatRoomId == null) {
              chatRoomId = await createChatroom(
                  user.uid,
                  userDetails['first_name'] + userDetails['last_name'],
                  widget.id,
                  widget.name);
            }
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Chat(
                          chatRoomId: chatRoomId,
                          name: widget.name,
                        )));
          },
        ),
        body: SafeArea(
          child: ListView(children: [
            Center(
                child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                widget.name,
                style: TextStyle(fontSize: 25, color: Colors.blue.shade900),
              ),
            )),
            Divider(color: Colors.lightBlue.shade300),
            posts != null && posts.size != 0
                ? ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: posts.size,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 15,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 15),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(),
                                Text(
                                  posts.docs[index].data()['topic'],
                                  style: TextStyle(
                                      color: Colors.blue.shade900,
                                      fontSize: 23),
                                ),
                                Text(
                                  DateFormat('EEE, dd MMM yyyy H:mm').format(
                                    DateTime.fromMillisecondsSinceEpoch(posts
                                            .docs[index]
                                            .data()['postTime']
                                            .seconds *
                                        1000),
                                  ),
                                  style: TextStyle(color: Colors.grey.shade600),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  posts.docs[index].data()['name'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ]),
                        ),
                      );
                    },
                  )
                : Container(),
          ]),
        ));
  }
}
