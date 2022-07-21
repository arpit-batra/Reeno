import 'package:flutter/material.dart';

class BookingWidget extends StatelessWidget {
  final durationHeight;
  const BookingWidget({required this.durationHeight, Key? key})
      : super(key: key);
  static const double bookingWidgetPadding = 3;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: bookingWidgetPadding),
            child: Stack(
              children: [
                Container(
                  height: durationHeight - (2 * bookingWidgetPadding),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                  height: durationHeight - (2 * bookingWidgetPadding),
                  width: 10,
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
