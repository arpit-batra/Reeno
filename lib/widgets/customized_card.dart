import 'package:flutter/material.dart';

class CustomizedCard extends StatelessWidget {
  final Widget? child;
  const CustomizedCard({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        width: double.infinity,
        color: const Color.fromRGBO(24, 28, 123, 1),
        child: child,
      ),
    );
  }
}
