import 'package:auth_firebase/src/models/UserModel.dart';
import 'package:auth_firebase/src/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  final name = 'usuario de prueba 2';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          SafeArea(
            child: _buildFormLogin(context),
          )
        ],
      ),
    );
  }

  Column _buildFormLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 40,
        ),
        _buildLogo(),
        SizedBox(
          height: 70,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: _buildTextInput(
              'Email', 'Email', Icons.email, TextInputType.emailAddress, false),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: _buildTextInput(
            'Password',
            'Password',
            Icons.lock,
            TextInputType.text,
            true,
          ),
        ),
         _buildFrogotPassword(),
        SizedBox(
          height: 25,
        ),
        _buildEnterButton(context),
       
      ],
    );
  }

  Container _buildLogo() {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xff00bd35),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Icon(
          Icons.verified_user,
          color: Colors.white,
          size: 100,
        ),
      );
  }

  Widget _buildFrogotPassword() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      alignment: Alignment.centerRight,
      child: FlatButton(
          padding: EdgeInsets.only(right: 0.0),
          onPressed: () => print('Forgot Password'),
          child: Text(
            '¿Olvidó su contraseña?',
            style: TextStyle(
              color: Color(0xff383838),
            ),
          )),
    );
  }

  Container _buildEnterButton(BuildContext context) {
    return Container(
      width: 250,
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: RaisedButton(
        elevation: 5.0,
        padding: EdgeInsets.all(15.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        color: Colors.white,
        child: Text(
          'Entrar',
          style: TextStyle(
              color: Colors.black54,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'),
        ),
        onPressed: () async {

          print(email);
          print(password);

         User user = await _auth.signInWithEmailAndPassword(email, password);

         if(user.uid != null && user != null) {
           Navigator.pushReplacementNamed(context, 'home');
         } else {
           print('error $user');
         }


          
          // Navigator.pushReplacementNamed(context, 'sidebarlayout');
        },
      ),
    );
  }

  Widget _buildTextInput(String hintText, String labelText, IconData icon,
      TextInputType textInputType, bool isPassword) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(labelText,
            style: TextStyle(
              color: Color(0xff383838),
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            )),
        SizedBox(
          height: 5.0,
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: Color(0xff383838), // fondo del input
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6.0,
                offset: Offset(0, 2),
              ),
            ],
          ),
          height: 60.0,
          child: (isPassword)
              ? _buildPassword(textInputType, isPassword, icon, hintText)
              : _buildEmail(textInputType, isPassword, icon, hintText),
        )
      ],
    );
  }

  TextField _buildEmail(TextInputType textInputType, bool isPassword,
      IconData icon, String hintText) {
    return TextField(
      onChanged: (value) {
        setState(() {
          this.email = value;
        });
      },
      keyboardType: textInputType,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white54,
            fontFamily: 'OpenSans',
          )),
    );
  }

  TextField _buildPassword(TextInputType textInputType, bool isPassword,
      IconData icon, String hintText) {
    return TextField(
      onChanged: (value) {
        setState(() {
          this.password = value;
        });
      },
      keyboardType: textInputType,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.only(top: 14.0),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white54,
            fontFamily: 'OpenSans',
          )),
    );
  }
}
