import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/widgets/loading_widget.dart';
import 'package:reeno/widgets/schedule_widgets/hour_widget.dart';
import 'package:reeno/providers/bookings_provider.dart';

class DaySchedule extends StatelessWidget {
  const DaySchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsProvider =
        Provider.of<BookingsProvider>(context, listen: false);
    final currDateProvider = Provider.of<SelectedDateProvider>(context);
    final sportCentreProvider = Provider.of<SportCentresProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder(
        future: bookingsProvider.fetchTodaysBookingsForCentre(
          currDateProvider.selectedDateInString,
          sportCentreProvider.selectedCentreMeta.detailsId,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print("data -> ${snapshot.data}");
            return ListView.builder(
              itemBuilder: ((context, index) =>
                  HourWidget(DateHelper.getReadableTime(index + 1))),
              itemCount: 23,
            );
          } else if (snapshot.hasError) {
            print("ERROR -> ${snapshot.error}");
            return Text(snapshot.error.toString());
          } else {
            return const LoadingWidget();
          }
        },
      ),
    );
  }
}
