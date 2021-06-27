import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:health_recovary_app/firstpage.dart';
import 'package:health_recovary_app/menu.dart';
import 'package:health_recovary_app/authentication/authentication_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await loaduserdata();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userDetails != null ? Menu() : FirstPage(),
    );
  }
}
