import 'package:auth_firebase/src/models/UserModel.dart';
import 'package:auth_firebase/src/services/auth_service.dart';
import 'package:auth_firebase/src/widgets/link_button_widget.dart';
import 'package:auth_firebase/src/widgets/text_field_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  final name = '';

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
          height: 40,
        ),
        _buildLogo(),
        SizedBox(
          height: 70,
        ),
        _buildEmail(),
        SizedBox(
          height: 15,
        ),
        _buildPassword(),
        _buildForgotPasswordBtn(),
        SizedBox(
          height: 25,
        ),
        _buildEnterButton(context),
        SizedBox(
          height: 15,
        ),
        _buildRegisterBtn(context)
      ],
    );
  }

  Widget _buildRegisterBtn(BuildContext context) {
    return LinkButtonWidget(
      onPressed: () {
        Navigator.pushReplacementNamed(context, 'signup');
      },
      textLink: '¿No tienes una cuenta?, regístrate',
      textColor: Color(0xff383838),
      aligment: Alignment.center,
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: LinkButtonWidget(
        onPressed: () {
          _showMyDialog();
        },
        textLink: '¿Olvidó su contraseña?',
        textColor: Color(0xff383838),
        aligment: Alignment.centerRight,
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: TextFieldWidget(
          hintText: 'Password',
          labelText: 'Password',
          icon: Icons.lock,
          textInputType: TextInputType.visiblePassword,
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

  Widget _buildLogo() {
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

          if (user.uid != null && user != null) {
            Navigator.pushReplacementNamed(context, 'home');
          } else {
            print('error $user');
          }

          // Navigator.pushReplacementNamed(context, 'sidebarlayout');
        },
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Recuperar contraseña'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextField(
                    onChanged: (value) {
                      this.email = value;
                    },
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: Colors.black38),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 14.0),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        hintText: 'Ingrea tu email',
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontFamily: 'OpenSans',
                        ))
                )
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Enviar'),
              onPressed: () async {
                if (this.email == '') {
                  showLongToast('Ingrese el email.');
                  return;
                }

                bool resp = await _auth.passwordRestoreWhitEmail(email);

                if (resp) {
                  showLongToast(
                      'Se ha enviado un correo a $email con las instrucciones para restablecer la contraseña.');
                  Navigator.of(context).pop();
                } else {
                  showLongToast('Error al recuperar contraseña.');
                  Navigator.of(context).pop();
                }
              },
            ),

            FlatButton(
              child: Text('Cerrar'),
              onPressed: () async {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showLongToast(String msg) {
    Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_LONG);
  }
}
