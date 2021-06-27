import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:refferencechecker/authentication/login.dart';
// import 'package:refferencechecker/authentication_service.dart';
// import 'package:refferencechecker/menu.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/gestures.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/authentication/login.dart';
import 'package:health_recovary_app/disease_checker.dart';
import 'package:health_recovary_app/menu.dart';
import 'package:health_recovary_app/orders.dart';
import 'package:health_recovary_app/validation.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  String firstname, lastname, email, password, con_password;
  bool _obscureText = true;
  bool _obscureText1 = true;
  int c = 0;
  bool vis1 = false,
      vis2 = false,
      vis3 = false,
      vis4 = false,
      vis5 = false,
      vis6 = false,
      vis7 = false,
      vis8 = false,
      vis9 = false,
      vis10 = false,
      vis11 = false;
  @override
  Widget build(BuildContext context) {
    //var GoogleFonts;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.lightBlue.shade300,
        title: Text('Sign Up',
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 35,
                color: Colors.white)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 400,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black),
                    keyboardType: TextInputType.text,
                    //SizedBox(height: 40),
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'FirstName'),
                    onChanged: (value) {
                      c++;
                      if (is_empty(value)) {
                        setState(() {
                          vis1 = true;
                        });
                      } else {
                        setState(() {
                          vis1 = false;
                          firstname = value;
                        });
                      }
                      if (!is_name(value)) {
                        setState(() {
                          vis2 = false;
                          firstname = value;
                        });
                      } else {
                        setState(() {
                          vis2 = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ),
                        labelText: 'First Name',
                        labelStyle: GoogleFonts.notoSans(
                          fontSize: MediaQuery.of(context).size.height / 45,
                          color: Colors.black,
                        ),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis1,
                      child: Text('First Name field is required',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis2,
                      child: Text(
                          'First Name cannot be a number or a special character',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black),
                    keyboardType: TextInputType.text,
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'LastName'),
                    onChanged: (value) {
                      c++;
                      if (is_empty(value)) {
                        setState(() {
                          vis3 = true;
                        });
                      } else {
                        setState(() {
                          vis3 = false;
                          lastname = value;
                        });
                      }
                      if (!is_name(value)) {
                        setState(() {
                          vis4 = false;
                          lastname = value;
                        });
                      } else {
                        setState(() {
                          vis4 = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: Colors.black,
                        ),
                        labelText: 'Last Name',
                        labelStyle: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 45,
                            color: Colors.black),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis3,
                      child: Text('Last Name field is required',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis4,
                      child: Text(
                          'Last Name cannot be a number or a special character',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.black)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      c++;
                      if (is_empty(value)) {
                        setState(() {
                          vis5 = true;
                        });
                      } else {
                        setState(() {
                          vis5 = false;
                          email = value;
                        });
                      }
                      if (is_email(value)) {
                        setState(() {
                          vis6 = false;
                          email = value;
                        });
                      } else {
                        setState(() {
                          vis6 = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        labelText: 'Email',
                        labelStyle: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 45,
                            color: Colors.black),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Visibility(
                    visible: vis5,
                    child: Text('Email field is required',
                        style: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 48,
                            color: Colors.red)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Visibility(
                    visible: vis6,
                    child: Text('Invalid email format',
                        style: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 48,
                            color: Colors.black)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black),
                    obscureText: _obscureText,
                    keyboardType: TextInputType.text,
                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'Password'),
                    onChanged: (value) {
                      c++;
                      password = value;
                      if (is_empty(password)) {
                        setState(() {
                          vis8 = true;
                        });
                      } else {
                        setState(() {
                          vis8 = false;
                        });
                      }
                      if (password != con_password) {
                        setState(() {
                          vis11 = true;
                        });
                      } else {
                        setState(() {
                          vis11 = false;
                        });
                      }
                      if (is_password(password)) {
                        setState(() {
                          vis9 = true;
                        });
                      } else {
                        setState(() {
                          vis9 = false;
                        });
                      }
                    },
                    //obscureText: true,
                    obscuringCharacter: '*',

                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                            color: Colors.black,
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            }),
                        labelText: 'Password',
                        labelStyle: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 45,
                            color: Colors.black),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis8,
                      child: Text('Password field is required',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis9,
                      child: Text(
                          'Password must contain atleast 6 characters,and consist of a letter and a number.',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black),
                    obscureText: _obscureText1,
                    keyboardType: TextInputType.emailAddress,

                    // TextFormField(
                    //   decoration: InputDecoration(labelText: 'Confirm Password'),
                    onChanged: (value) {
                      c++;
                      con_password = value;
                      if (is_empty(value)) {
                        setState(() {
                          vis10 = true;
                        });
                      } else {
                        setState(() {
                          vis10 = false;
                        });
                      }
                      if (password != value) {
                        setState(() {
                          vis11 = true;
                        });
                      } else {
                        setState(() {
                          vis11 = false;
                        });
                      }
                    },
                    //obscureText: true,
                    obscuringCharacter: '*',

                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.black,
                        )),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                            color: Colors.black,
                            icon: Icon(
                              _obscureText1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText1 = !_obscureText1;
                              });
                            }),
                        labelText: 'Confirm Password',
                        labelStyle: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 45,
                            color: Colors.black),
                        errorStyle: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis10,
                      child: Text('Confirm Password field is required',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Visibility(
                      visible: vis11,
                      child: Text(
                          'Password and confirm password should be same',
                          style: GoogleFonts.notoSans(
                              fontSize: MediaQuery.of(context).size.height / 48,
                              color: Colors.red)),
                    )),
                SizedBox(height: 30),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  width: MediaQuery.of(context).size.width / 2,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Colors.lightBlue.shade300),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(color: Colors.white)))),
                      onPressed: (vis1 ||
                              vis2 ||
                              vis3 ||
                              vis4 ||
                              vis5 ||
                              vis6 ||
                              vis7 ||
                              vis8 ||
                              vis9 ||
                              vis10 ||
                              vis11)
                          ? null
                          : () async {
                              if (firstname != null &&
                                  lastname != null &&
                                  email != null &&
                                  password != null &&
                                  con_password != null) {
                                Map<String, dynamic> details = {
                                  'first_name': firstname.trim().toLowerCase(),
                                  'last_name': lastname.trim().toLowerCase(),
                                  'email': email,
                                };
                                print(details['first_name']);
                                print(details['last_name']);
                                await sign_up(details, email, password);
                                Navigator.pop(context);
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Menu()));
                              }
                            },
                      child: Text(
                        'Sign Up',
                        style: GoogleFonts.notoSans(
                            fontSize: MediaQuery.of(context).size.height / 35,
                            color: Colors.white),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    "Already have an account?",
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black),
                  ),
                ),
                FlatButton(
                    onPressed: () async {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                      // FirebaseFirestore.instance
                      //     .collectionGroup('posts').where('topic',isEqualTo:'covid').orderBy('postTime',descending: true)
                      //     .get()
                      //     .then((QuerySnapshot querySnapshot) => {
                      //           querySnapshot.docs.forEach((doc) {
                      //             print(doc.data().toString());
                      //           }),
                      //         });
                    },
                    child: Text(
                      " Login",
                      style: GoogleFonts.notoSans(
                          fontSize: MediaQuery.of(context).size.height / 45,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
