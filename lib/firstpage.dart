import 'package:flutter/material.dart';
import 'package:health_recovary_app/authentication/login.dart';
import 'package:health_recovary_app/authentication/signup.dart';
import 'package:google_fonts/google_fonts.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
            ),
            // SizedBox(
            //   height: 300,
            //   width: 300,
            // ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Welcome To Health Recovary App',
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 45,
                        color: Colors.black)),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue.shade300),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                            side: BorderSide(color: Colors.white)))),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: Text('Get Started',
                    style: GoogleFonts.notoSans(
                        fontSize: MediaQuery.of(context).size.height / 48,
                        color: Colors.white))),
          ],
        ),
      ),
    );
  }
}
