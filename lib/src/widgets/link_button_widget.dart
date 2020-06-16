import 'package:flutter/material.dart';

class LinkButtonWidget extends StatelessWidget {

  final Function onPressed;
  final String textLink;
  final Color textColor;
  final Alignment aligment;

  const LinkButtonWidget({
    @required this.onPressed,
    @required this.textLink,
    this.textColor = Colors.black38, 
    this.aligment = Alignment.center
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        // margin: EdgeInsets.only(right: 20),
        alignment: this.aligment,
        child: FlatButton(
            padding: EdgeInsets.only(right: 0.0),
            onPressed: this.onPressed,
            child: Text(
              this.textLink,
              style: TextStyle(
                color: this.textColor,
              ),
            )),
      );
  }
}