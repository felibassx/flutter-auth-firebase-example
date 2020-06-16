import 'package:auth_firebase/src/models/UserModel.dart';
import 'package:auth_firebase/src/services/auth_service.dart';
import 'package:auth_firebase/src/widgets/link_button_widget.dart';
import 'package:auth_firebase/src/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _auth = AuthService();

  String email = '';
  String password = '';
  String passwordConfirm = '';
  String displayName = '';
  String photoUrl = '';
  String phoneNumber = '';

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

  Widget _buildFormLogin(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        _buildLogo(),
        SizedBox(
          height: 30,
        ),
        _buildName(),
        SizedBox(
          height: 15,
        ),
        _buildEmail(),
        SizedBox(
          height: 15,
        ),
        _buildPassword(),
        SizedBox(
          height: 15,
        ),
        _buildPasswordConfirm(),
        SizedBox(
          height: 25,
        ),
        _buildEnterButton(context),
        SizedBox(
          height: 15,
        ),
        LinkButtonWidget(
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'signin');
          },
          textLink: '¿Ya tienes una cuenta?, ingresa aquí',
          textColor: Color(0xff383838),
        )
      ],
    );
  }

  Widget _buildPasswordConfirm() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFieldWidget(
          hintText: 'Confirmar Password',
          labelText: 'Confirmar Password',
          icon: Icons.lock,
          textInputType: TextInputType.text,
          isPassword: true,
          onChanged: (value) {
            setState(() {
              this.passwordConfirm = value;
            });
          }),
    );
  }

  Widget _buildPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFieldWidget(
          hintText: 'Password',
          labelText: 'Password',
          icon: Icons.lock,
          textInputType: TextInputType.text,
          isPassword: true,
          onChanged: (value) {
            setState(() {
              this.password = value;
            });
          }),
    );
  }

  Widget _buildEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFieldWidget(
          hintText: 'Email',
          labelText: 'Email',
          icon: Icons.email,
          textInputType: TextInputType.emailAddress,
          isPassword: false,
          onChanged: (value) {
            setState(() {
              this.email = value;
            });
          }),
    );
  }

  Widget _buildName() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFieldWidget(
          hintText: 'Nombre',
          labelText: 'Nombre',
          icon: Icons.verified_user,
          textInputType: TextInputType.text,
          isPassword: false,
          onChanged: (value) {
            setState(() {
              this.displayName = value;
            });
          }),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xff00bd35),
        borderRadius: BorderRadius.circular(100.0),
      ),
      child: Icon(
        Icons.add_to_home_screen,
        color: Colors.white,
        size: 100,
      ),
    );
  }

  Widget _buildEnterButton(BuildContext context) {
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
          'Registrar',
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
          print(passwordConfirm);
          print(displayName);

          User user =
              await _auth.registerWithEmailAndPassword(password, displayName, photoUrl, email, phoneNumber);

          if (user.uid != null && user != null) {
            print(user);
            Navigator.pushReplacementNamed(context, 'home');
          } else {
            print('error $user');
          }

          Navigator.pushReplacementNamed(context, 'sidebarlayout');
        },
      ),
    );
  }
}
