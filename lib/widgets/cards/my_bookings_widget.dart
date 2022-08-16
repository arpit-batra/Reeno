import 'package:flutter/material.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/widgets/card_ui/card_text_styles.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';

class MyBookingsWidget extends StatelessWidget {
  final Booking booking;
  const MyBookingsWidget(this.booking, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomizedCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Address and payment
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    booking.sportCentreTitle,
                    style: CardTextStyles.primaryInfoStyle(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Booking Cost",
                    style: CardTextStyles.smallHeadingStyle(),
                  ),
                  Text(
                    "₹${booking.amount.toString()}",
                    style: CardTextStyles.bookingWidgetCostStyle(),
                  )
                ],
              ),
            ),
          ),
          //Date and Time
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    DateHelper.getReadableDate(booking.date),
                    style: CardTextStyles.bookingWidgetDateStyle(),
                    textAlign: TextAlign.end,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "${DateHelper.dateTimeToTimeOfDayInString(booking.startTime)} - ${DateHelper.dateTimeToTimeOfDayInString(booking.endTime)}",
                    style: CardTextStyles.bookingWidgetTimeStyle(),
                    textAlign: TextAlign.end,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
