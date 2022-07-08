import 'package:flutter/material.dart';

class CentreListTile extends StatelessWidget {
  const CentreListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
            'https://t3.ftcdn.net/jpg/02/23/27/28/360_F_223272802_WitEnJSzsXNKaqESPFSdfmuR0KeDjbV6.jpg'),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(0, 0, 0, 0),
            Color.fromARGB(1, 255, 255, 22)
          ])),
        ),
        Text("Sample Court"),
      ],
    );
  }
}
