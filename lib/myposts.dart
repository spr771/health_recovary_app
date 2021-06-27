import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/addnewpost.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';

class MyPosts extends StatefulWidget {
  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  QuerySnapshot posts;
  getposts() async {
    posts = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('posts')
        .orderBy('postTime', descending: true)
        .get();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getposts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('My Posts'),
          backgroundColor: Colors.lightBlue.shade300,
        ),
        body: Column(
          children: [
            posts != null && posts.size > 0
                ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Text(''),
                            ListTile(
                                tileColor: Colors.amber[100],
                                subtitle:
                                    Text(posts.docs[index].data()['topic']),
                                trailing: IconButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user.uid)
                                        .collection('posts')
                                        .doc(posts.docs[index].id)
                                        .delete();
                                    getposts();
                                  },
                                  icon: Icon(Icons.delete),
                                ),
                                title: Text(posts.docs[index].data()['name'])),
                          ],
                        );
                      },
                      itemCount: posts.size,
                    ),
                  )
                : posts == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(''),
                          Center(child: CircularProgressIndicator()),
                        ],
                      )
                    : Flexible(
                        child: Text(
                            'You do not have any posts, Press the + button to add new post')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var reply = await Navigator.push(
                context, MaterialPageRoute(builder: (context) => NewPost()));
            if (reply == 'done') {
              getposts();
            }
          },
          child: Icon(Icons.add),
        ));
  }
}
