import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/loading_widget.dart';
import 'package:reeno/widgets/schedule_widgets/date_picker.dart';
import 'package:reeno/widgets/schedule_widgets/day_schedule.dart';
import 'package:reeno/widgets/schedule_widgets/time_selector.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  static const routeName = "/schedule-screen";

  void showTimePickerDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return TimeSelector();
        });
  }

  @override
  Widget build(BuildContext context) {
    final centreMeta =
        Provider.of<SportCentresProvider>(context).selectedCentreMeta;
    return Scaffold(
      appBar: AppBar(title: Text(centreMeta.title)),
      // appBar: AppBar(title: Text("dfgf")),
      drawer: const AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<SelectedDateProvider>(context, listen: false)
            .setSelectedDateAsCurrDate(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            return Column(children: <Widget>[
              const SizedBox(
                height: 100,
                width: double.infinity,
                child: DatePicker(),
              ),
              const Expanded(
                child: DaySchedule(),
              ),
              Container(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                width: double.infinity,
                height: 64,
                child: ElevatedButton(
                    onPressed: (() {
                      showTimePickerDialog(context);
                    }),
                    child: const Text(
                      'Book my slot',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    )),
              )
            ]);
          }
        },
      ),
    );
  }
}
