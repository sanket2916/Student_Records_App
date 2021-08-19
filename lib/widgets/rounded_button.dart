import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String keyText;
  final Function() onPress;
  final Color? color;
  final BorderRadius? borderRadius;

  RoundedButton({required this.keyText, required this.onPress, this.color, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: borderRadius,
        child: MaterialButton(
          onPressed: onPress,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            keyText,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18
            ),
          ),
        ),
      ),
    );
  }
}