import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/database_calls.dart';

class Chat extends StatefulWidget {
  String chatRoomId;
  String name;

  Chat({
    this.chatRoomId,
    this.name,
  });
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _textController = TextEditingController();
  QuerySnapshot msgs;
  String newmsg;
  startChat() {
    FirebaseFirestore.instance
        .collection('chat_rooms')
        .doc(widget.chatRoomId)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots()
        .listen((event) {
      msgs = event;
      print(msgs);
      setState(() {});
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startChat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: CircleAvatar(
        //     backgroundImage: NetworkImage(widget.profile_image),
        //   ),
        // ),
        title: Text(widget.name),
      ),
      body: Column(
        children: [
          Expanded(
              child: msgs != null && msgs.size != 0
                  ? ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      itemBuilder: (context, index) {
                        // return Center(
                        //   child: Container(
                        //     width: 300,
                        //     child: Text(
                        //       msgs.docs[index].data()['msg'],
                        //       textAlign:
                        //           msgs.docs[index].data()['sender'] == user.uid
                        //               ? TextAlign.right
                        //               : TextAlign.left,
                        //     ),
                        //   ),
                        // );

                        return Container(
                          padding: EdgeInsets.only(
                              left: 14, right: 14, top: 10, bottom: 10),
                          child: Align(
                            alignment: (msgs.docs[index]['sender'] == user.uid
                                ? Alignment.topRight
                                : Alignment.topLeft),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: (msgs.docs[index]['sender'] == user.uid
                                    ? Colors.blue.shade200
                                    : Colors.grey.shade400),
                              ),
                              padding: EdgeInsets.all(16),
                              child: Text(
                                msgs.docs[index]['msg'],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: msgs.size,
                    )
                  : Text("Start talking ")),
          // Row(
          //   children: [
          //     Container(
          //       width: 200,
          //       child: TextFormField(
          //         controller: _textController,
          //         decoration: InputDecoration(labelText: 'write msg'),
          //         onChanged: (val) {
          //           newmsg = val;

          //           setState(() {});
          //         },
          //       ),
          //     ),
          //     newmsg != null && newmsg != ''
          //         ? ElevatedButton(
          //             onPressed: () {
          //               sendChat(widget.chatRoomId, newmsg);
          //               newmsg = null;
          //               _textController.clear();
          //               setState(() {});
          //             },
          //             child: Text('send'))
          //         : Text("")
          //   ],
          // )
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                  height: 60,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color: Colors.lightBlue,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _textController,
                          decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(color: Colors.black54),
                              border: InputBorder.none),
                          onChanged: (val) {
                            newmsg = val;

                            setState(() {});
                          },
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      newmsg != null && newmsg != ''
                          ? FloatingActionButton(
                              onPressed: () {
                                sendChat(widget.chatRoomId, newmsg);
                                newmsg = null;
                                _textController.clear();
                                setState(() {});
                              },
                              child: Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 18,
                              ),
                              backgroundColor: Colors.blue,
                              elevation: 0,
                            )
                          : Text(""),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
