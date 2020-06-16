import 'package:auth_firebase/src/services/auth_service.dart';
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Home Page!!!'),
            RaisedButton(
              onPressed: () async {
                dynamic resp = await _auth.signOut();
                print(resp);
                if(resp != null) {
                  Navigator.pushReplacementNamed(context, 'signin');
                }
              },
              child: Text('Logout'),
            )
          ],
        ),
     ),
   );
  }
}