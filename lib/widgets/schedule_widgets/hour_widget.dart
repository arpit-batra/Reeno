import 'package:flutter/material.dart';

class HourWidget extends StatelessWidget {
  final String time;
  final double heightOfHourWidget;
  const HourWidget(this.time, this.heightOfHourWidget, {Key? key})
      : super(key: key);
  static const double borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: heightOfHourWidget,
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.black,
            width: borderWidth,
          ))),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: const Color.fromRGBO(196, 196, 196, 1),
                  height: heightOfHourWidget - borderWidth,
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Container(
                      height: (heightOfHourWidget - borderWidth) / 2,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(241, 241, 241, 1),
                        border: Border.all(
                          width: 1,
                          color: const Color.fromRGBO(200, 200, 200, 1),
                        ),
                      ),
                    ),
                    Container(
                      height: (heightOfHourWidget - borderWidth) / 2,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(229, 229, 229, 1),
                        border: Border.all(
                          width: 1,
                          color: const Color.fromRGBO(200, 200, 200, 1),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Positioned(
          left: 5,
          bottom: 4,
          child: Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
