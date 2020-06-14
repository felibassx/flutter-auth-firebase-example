import 'package:auth_firebase/src/models/UserModel.dart';
import 'package:auth_firebase/src/services/auth_service.dart';
import 'package:flutter/material.dart';

class SigninPage extends StatelessWidget {
  
  final AuthService _auth = AuthService();

  final email = 'felibass@gmail.com';
  final password = 'pipexx221';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: RaisedButton(
                child: Text('Register'),
                onPressed: () async {

                  dynamic result = await _auth.registerWithEmailAndPassword(email, password);

                  if(result == null) {
                    print('Error REGISTER');
                  } else {
                    print('REGISTER OK');
                    result = result as User;
                    print(result.uid);
                  }

                },

              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: RaisedButton(
                child: Text('Signin'),
                onPressed: () async {

                  dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                  if(result == null) {
                    print('Error SIGNIN');
                  } else {
                    print('Signin OK');
                    result = result;
                    print(result.uid);
                  }

                },

              ),
            ),
          ],
        ),
      ),
    );
  }
}