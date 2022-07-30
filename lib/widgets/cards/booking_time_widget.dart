import 'package:flutter/material.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/widgets/card_ui/card_text_styles.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';
import 'package:reeno/helpers/date_helper.dart';

class BookingTimeWidget extends StatelessWidget {
  final Booking selectedBooking;
  final bool dark;
  const BookingTimeWidget(this.selectedBooking, {this.dark = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomizedCard(
      dark: dark,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Time of Booking",
              style: CardTextStyles.headingStyle(),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              selectedBooking.date,
              style: CardTextStyles.primaryInfoStyle(),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "${DateHelper.DateTimeToTimeOfDayInString(selectedBooking.startTime)} - ${DateHelper.DateTimeToTimeOfDayInString(selectedBooking.endTime)}",
              style: CardTextStyles.secondaryInfoStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
