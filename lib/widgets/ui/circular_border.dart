import 'package:flutter/material.dart';

class CircularBorder extends StatelessWidget {
  final Widget child;
  double? borderWidth;
  Color? borderColor;
  CircularBorder(
      {required this.child, this.borderWidth, this.borderColor, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
            width: borderWidth ?? 1, color: borderColor ?? Colors.black),
      ),
      child: child,
    );
  }
}
