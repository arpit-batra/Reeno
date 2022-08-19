import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/helpers/date_helper.dart';

import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/loading_widget.dart';
import 'package:reeno/widgets/schedule_widgets/date_picker.dart';
import 'package:reeno/widgets/schedule_widgets/day_schedule.dart';
import 'package:reeno/widgets/schedule_widgets/time_selector.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  static const routeName = "/schedule-screen";

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  bool _isFirstRun = true;
  int courtNo = 0;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (_isFirstRun) {
  //     _isFirstRun = false;
  //     courtNo = ModalRoute.of(context)!.settings.arguments as int;
  //   }
  // }

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
                child: Consumer<SelectedDateProvider>(
                  builder: ((context, selectedDateProvider, child) {
                    print(selectedDateProvider.selectedDateInDateTime);
                    print(snapshot.data as DateTime);

                    if (DateHelper.firstDateBeforeSecond(
                        selectedDateProvider.selectedDateInDateTime,
                        snapshot.data as DateTime)) {
                      return const ElevatedButton(
                          onPressed: null,
                          child: Text(
                            'Book my slot',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ));
                    } else {
                      return ElevatedButton(
                          onPressed: (() {
                            showTimePickerDialog(context);
                          }),
                          child: const Text(
                            'Book my slot',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            textAlign: TextAlign.center,
                          ));
                    }
                  }),
                ),
              )
            ]);
          }
        },
      ),
    );
  }
}
