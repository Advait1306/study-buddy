import 'package:flutter/material.dart';

class HighlightedButton extends StatelessWidget {
  final Icon icon;
  final Function() onPressed;
  const HighlightedButton(
      {Key? key, required this.icon, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xffcafe48),
          borderRadius: BorderRadius.circular(20)
        ),
        width: 83,
        height: 35,
        child: Center(
          child: icon,
        ),
      ),
    );
  }
}
