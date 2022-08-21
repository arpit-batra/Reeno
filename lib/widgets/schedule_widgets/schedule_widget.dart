import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/providers/bookings_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/widgets/schedule_widgets/hour_widget.dart';
import 'package:reeno/widgets/schedule_widgets/booking_widget.dart';

class ScheduleWidget extends StatelessWidget {
  static const double heightPerHour = 100;
  static const double schedulePadding = 16;
  const ScheduleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = Provider.of<BookingsProvider>(context);
    final bookingList =
        bookingsProvider.selectedDateSelectedCentreSelectedCourtBookings;
    final user = Provider.of<UserProvider>(context, listen: false).user;
    final selectedSportCentreId =
        Provider.of<SportCentresProvider>(context, listen: false)
            .selectedCentreId;
    final shouldShowNames = !(user!.owner == null ||
        user.owner == false ||
        user.centreId != selectedSportCentreId);
    return Padding(
      padding: const EdgeInsets.all(schedulePadding),
      child: SingleChildScrollView(
        controller: ScrollController(initialScrollOffset: 6 * heightPerHour),
        child: SizedBox(
          height: heightPerHour * 24,
          child: Stack(
            children: [
              ...List.generate(
                24,
                (index) => Positioned(
                  top: index * heightPerHour,
                  width:
                      MediaQuery.of(context).size.width - (2 * schedulePadding),
                  child: HourWidget(
                      DateHelper.getReadableTime(index + 1), heightPerHour),
                ),
              ),
              //Displaying Bookings
              ...List.generate(bookingList.length, ((index) {
                final booking = bookingList[index];
                final heightOfWidget = DateHelper.getDurationHeight(
                    booking.startTime, booking.endTime, heightPerHour);
                final placementFromTop = DateHelper.getPlacementFromTop(
                    booking.startTime, heightPerHour);
                return Positioned(
                    top: placementFromTop,
                    width: MediaQuery.of(context).size.width -
                        (2 * schedulePadding),
                    child: BookingWidget(
                        durationHeight: heightOfWidget,
                        userName: shouldShowNames ? booking.userName : ""));
              })),
            ],
          ),
        ),
      ),
    );
  }
}
