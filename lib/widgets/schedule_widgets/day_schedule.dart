import 'package:flutter/material.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/widgets/schedule_widgets/hour_widget.dart';

class DaySchedule extends StatelessWidget {
  const DaySchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemBuilder: ((context, index) =>
            HourWidget(DateHelper.getReadableTime(index + 1))),
        itemCount: 23,
      ),
    );
  }
}
