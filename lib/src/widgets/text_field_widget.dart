import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    @required this.hintText,
    @required this.labelText,
    @required this.icon,
    @required this.textInputType,
    @required this.isPassword,
    @required this.onChanged,
  }) : super(key: key);

  final String hintText;
  final String labelText;
  final IconData icon;
  final TextInputType textInputType;
  final bool isPassword;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
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
          child: TextField(
            onChanged: onChanged,
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
          ),
        )
      ],
    );
  }
}