import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/dialogs.dart';
import 'package:health_recovary_app/firstpage.dart';
import 'package:health_recovary_app/myposts.dart';

class myprofile extends StatefulWidget {
  @override
  _myprofileState createState() => _myprofileState();
}

class _myprofileState extends State<myprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: GoogleFonts.notoSans(
              fontWeight: FontWeight.bold,
              fontSize: MediaQuery.of(context).size.height / 35,
              color: Colors.white),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.lightBlue.shade300,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 25,
              vertical: MediaQuery.of(context).size.height / 80,
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                Container(
                  child: Text(
                    userDetails['first_name'] + " " + userDetails['last_name'],
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black87,
                        fontFamily: 'Andika New Basic',
                        fontSize: MediaQuery.of(context).size.height / 35,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.lightBlue.shade300,
            ),
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.height / 25,
              vertical: MediaQuery.of(context).size.height / 80,
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(),
                Container(
                  child: Text(
                    userDetails['email'],
                    style: TextStyle(
                        letterSpacing: 1.0,
                        color: Colors.black87,
                        fontFamily: 'Andika New Basic',
                        fontSize: MediaQuery.of(context).size.height / 35,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            //color: Colors.white,
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPosts()));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightBlue.shade300,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height / 25,
                vertical: MediaQuery.of(context).size.height / 80,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.post_add_sharp),
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 45,
                        ),
                        Text(
                          'My Posts',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black87,
                              fontFamily: 'Andika New Basic',
                              fontSize: MediaQuery.of(context).size.height / 35,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            //color: Colors.white,
            onTap: () async {
              final action = await dialogs.yesabortdialog(
                  context, 'Confirm', 'Are you sure?');
              if (action == DialogAction.yes) {
                await logout();
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => FirstPage()));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.lightBlue.shade300,
              ),
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.height / 25,
                vertical: MediaQuery.of(context).size.height / 80,
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(
                          width: MediaQuery.of(context).size.height / 45,
                        ),
                        Text(
                          'Log Out',
                          style: TextStyle(
                              letterSpacing: 1.0,
                              color: Colors.black87,
                              fontFamily: 'Andika New Basic',
                              fontSize: MediaQuery.of(context).size.height / 35,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
