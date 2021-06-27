import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/validation.dart';

class NewPost extends StatefulWidget {
  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String topic, post;
  addpost(String topic, String post) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('posts')
        .add({
      'topic': topic,
      'name': post,
      'postTime': FieldValue.serverTimestamp(),
      'username': capitalize(userDetails['first_name']) +
          ' ' +
          capitalize(userDetails['last_name']),
      'user_id': user.uid,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add new posts'),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(11.0),
            child: TextFormField(
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              style: GoogleFonts.notoSans(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  color: Colors.black),
              onChanged: (value) {
                topic = value;
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  prefixIcon: Icon(
                    Icons.topic,
                    color: Colors.black,
                  ),
                  labelText: 'Topic',
                  labelStyle: GoogleFonts.notoSans(
                      fontSize: MediaQuery.of(context).size.height / 45,
                      color: Colors.black),
                  errorStyle: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(11.0),
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              cursorColor: Colors.black,
              style: GoogleFonts.notoSans(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  color: Colors.black),
              onChanged: (value) {
                post = value;
              },
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                    color: Colors.black,
                  )),
                  prefixIcon: Icon(
                    Icons.post_add,
                    color: Colors.black,
                  ),
                  labelText: 'Write something to post',
                  labelStyle: GoogleFonts.notoSans(
                      fontSize: MediaQuery.of(context).size.height / 45,
                      color: Colors.black),
                  errorStyle: TextStyle(
                    color: Colors.black,
                  )),
            ),
          ),
          SizedBox(height: 30),
          Container(
            height: MediaQuery.of(context).size.height / 15,
            width: MediaQuery.of(context).size.width / 2,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue.shade300),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width * 0.08),
                            side: BorderSide(color: Colors.white)))),
                onPressed: () async {
                  if (topic == null || topic == ' ' || topic == '') {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.lightBlue.shade300,
                        msg: 'Please write topic of your post');
                  } else if (post == null || post == ' ' || post == '') {
                    Fluttertoast.showToast(
                        backgroundColor: Colors.lightBlue.shade300,
                        msg: ' Write Something to post');
                  } else {
                    await addpost(topic, post);
                    Navigator.pop(context, 'done');
                  }
                },
                child: Text(
                  'Add Post',
                  style: GoogleFonts.notoSans(
                      fontSize: MediaQuery.of(context).size.height / 35,
                      color: Colors.white),
                )),
          ),
        ]),
      ),
    );
  }
}
