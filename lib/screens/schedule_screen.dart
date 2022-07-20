import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/schedule_widgets/dates_strip.dart';
import 'package:reeno/widgets/schedule_widgets/day_schedule.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  static const routeName = "/schedule-screen";

  @override
  Widget build(BuildContext context) {
    // final centreMeta = Provider.of<SportCentresProvider>(context, listen: false)
    //     .selectedCentreMeta;
    // final selectedDateProvider =
    //     Provider.of<SelectedDateProvider>(context).selectedDate;
    return Scaffold(
      // appBar: AppBar(title: Text(centreMeta.title)),
      appBar: AppBar(title: Text("dfgf")),
      drawer: const AppDrawer(),
      body: Column(children: <Widget>[
        const SizedBox(
          height: 100,
          width: double.infinity,
          child: DatesStrip(),
        ),
        const Expanded(
          child: DaySchedule(),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          width: double.infinity,
          height: 64,
          child: ElevatedButton(
              onPressed: (() {}),
              child: const Text(
                'Book my slot',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              )),
        )
      ]),
    );
  }
}
