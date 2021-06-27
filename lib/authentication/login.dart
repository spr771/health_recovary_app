import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';
import 'package:health_recovary_app/authentication/signup.dart';
import 'package:health_recovary_app/menu.dart';

import '../disease_checker.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    bool _obscureText = true;
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in",
            style: GoogleFonts.notoSans(
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.height / 35,
                color: Colors.white)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.lightBlue.shade300,
      ),
      body: SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Padding(
            padding: EdgeInsets.all(11.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              style: GoogleFonts.notoSans(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  color: Colors.black),
              onChanged: (value) {
                setState(() {
                  email = value;
                });
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
            padding: EdgeInsets.all(11.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              cursorColor: Colors.black,
              obscureText: _obscureText,
              obscuringCharacter: '*',
              style: GoogleFonts.notoSans(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  color: Colors.black),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
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
                        _obscureText ? Icons.visibility_off : Icons.visibility,
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
                  EasyLoading.show(status: 'Authenticating...');
                  try {
                    print(email);
                    print(password);
                    await login(email, password);
                    if (userDetails != null) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Menu()));
                      EasyLoading.showSuccess('Logged in successfully');
                    }
                    EasyLoading.dismiss();
                  } catch (e) {
                    EasyLoading.showError(
                      e.message,
                    );
                  }
                },
                child: Text(
                  'Login',
                  style: GoogleFonts.notoSans(
                      fontSize: MediaQuery.of(context).size.height / 35,
                      color: Colors.white),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              "Don't have an account yet?",
              style: GoogleFonts.notoSans(
                  fontSize: MediaQuery.of(context).size.height / 45,
                  color: Colors.black),
            ),
          ),
          FlatButton(
              onPressed: () async {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => signup()));
              },
              child: Text(
                " SignUp",
                style: GoogleFonts.notoSans(
                    fontSize: MediaQuery.of(context).size.height / 45,
                    color: Colors.black,
                    decoration: TextDecoration.underline),
              ))
        ]),
      ),
    );
  }
}
