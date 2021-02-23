import 'package:flutter/material.dart';

class CalcButton extends StatefulWidget {
  final color;
  final textColor;
  final buttonText;
  final buttonTap;

  const CalcButton(
      {Key key, this.color, this.textColor, this.buttonText, this.buttonTap})
      : super(key: key);

  @override
  _CalcButtonState createState() => _CalcButtonState();
}

class _CalcButtonState extends State<CalcButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.buttonTap,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
        ),
        child: Center(
          child: Text(
            widget.buttonText,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: widget.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
