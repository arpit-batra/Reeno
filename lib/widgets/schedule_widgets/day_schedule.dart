import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/widgets/loading_widget.dart';
import 'package:reeno/widgets/schedule_widgets/booking_widget.dart';
import 'package:reeno/widgets/schedule_widgets/hour_widget.dart';
import 'package:reeno/providers/bookings_provider.dart';

class DaySchedule extends StatelessWidget {
  const DaySchedule({Key? key}) : super(key: key);
  static const double heightOfHourWidget = 100;
  static const double schedulePading = 16;

  @override
  Widget build(BuildContext context) {
    final bookingsProvider =
        Provider.of<BookingsProvider>(context, listen: false);
    final currDateProvider = Provider.of<SelectedDateProvider>(context);
    final sportCentreProvider = Provider.of<SportCentresProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(schedulePading),
      child: FutureBuilder(
        future: bookingsProvider.fetchTodaysBookingsForCentre(
          currDateProvider.selectedDateInString,
          sportCentreProvider.selectedCentreMeta.detailsId,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final bookingList = snapshot.data as List<Booking>;
            return SingleChildScrollView(
              controller:
                  ScrollController(initialScrollOffset: 6 * heightOfHourWidget),
              child: Container(
                height: heightOfHourWidget * 24,
                child: Stack(
                  children: [
                    ...List.generate(
                      24,
                      (index) => Positioned(
                        top: index * heightOfHourWidget,
                        width: MediaQuery.of(context).size.width -
                            (2 * schedulePading),
                        child: HourWidget(DateHelper.getReadableTime(index + 1),
                            heightOfHourWidget),
                      ),
                    ),
                    //Displaying Bookings
                    ...List.generate(bookingList.length, ((index) {
                      final booking = bookingList[index];
                      final heightOfWidget = DateHelper.getDurationHeight(
                          booking.startTime,
                          booking.endTime,
                          heightOfHourWidget);
                      final placementFromTop = DateHelper.getPlacementFromTop(
                          booking.startTime, heightOfWidget);
                      return Positioned(
                          top: placementFromTop,
                          width: MediaQuery.of(context).size.width -
                              (2 * schedulePading),
                          child: BookingWidget(
                            durationHeight: heightOfWidget,
                          ));
                    })),
                  ],
                ),
              ),
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
