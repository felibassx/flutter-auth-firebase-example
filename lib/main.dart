
import 'package:auth_firebase/src/pages/auth/siginin_page.dart';
import 'package:auth_firebase/src/pages/home_page.dart';
import 'package:flutter/material.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Auth Firebase Example',
      home: SignInPage(),
      routes: {
        'home': (BuildContext context) => HomePage(),
        'signin': (BuildContext context) => SignInPage(),
      },
    );
  }
}