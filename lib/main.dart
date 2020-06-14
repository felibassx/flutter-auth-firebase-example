import 'package:auth_firebase/src/pages/auth/signup_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Firebase Example',
      home: SigninPage(),
    );
  }
}