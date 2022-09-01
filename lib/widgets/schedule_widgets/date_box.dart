import 'package:flutter/material.dart';
import 'package:reeno/helpers/date_helper.dart';

class DateBox extends StatelessWidget {
  final bool isSelected;
  final DateTime date;
  final Function? onTap;
  const DateBox(
      {required this.isSelected, required this.date, this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap == null) {
          return;
        } else {
          onTap!();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(147, 147, 147, 1),
                blurRadius: 3,
                offset: Offset.fromDirection(0, 1)),
          ],
          color: isSelected
              ? const Color.fromARGB(1023, 255, 0, 61)
              : const Color.fromARGB(1023, 241, 241, 241),
        ),
        height: 80,
        width: MediaQuery.of(context).size.width / 6,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                DateHelper.getDayOfWeek(date),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Color.fromRGBO(147, 147, 147, 1),
                  fontSize: 14,
                ),
              ),
            ),
            // const SizedBox(
            //   height: 4,
            // ),
            Expanded(
              flex: 3,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "${DateHelper.getdayOfMonth(date)}",
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Color.fromRGBO(0, 0, 0, 1),
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
            ),
            // const SizedBox(
            //   height: 4,
            // ),
            Expanded(
              flex: 1,
              child: Text(
                DateHelper.getMonthShort(date),
                style: TextStyle(
                  color: isSelected
                      ? Colors.white
                      : Color.fromRGBO(147, 147, 147, 1),
                  fontSize: 14,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
