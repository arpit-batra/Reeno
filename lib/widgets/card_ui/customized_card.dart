import 'package:flutter/material.dart';

class CustomizedCard extends StatelessWidget {
  final Widget? child;
  final bool dark;
  const CustomizedCard({this.child, this.dark = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        width: double.infinity,
        color: dark
            ? const Color.fromRGBO(24, 28, 123, 1)
            : Theme.of(context).primaryColor,
        child: child,
      ),
    );
  }
}
