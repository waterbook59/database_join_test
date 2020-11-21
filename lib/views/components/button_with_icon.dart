import 'package:flutter/material.dart';

class ButtonWithIcon extends StatelessWidget {

  const ButtonWithIcon(
      {@required this.onPressed, this.icon,
        this.label, this.buttonColor, this.textColor});

  final VoidCallback onPressed;
  final Widget icon;
  final String label;
  final Color buttonColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: RaisedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(
            label, style: TextStyle(fontSize: 16, color: textColor),),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)),
          color: buttonColor,
        ),
      ),
    );
  }
}
