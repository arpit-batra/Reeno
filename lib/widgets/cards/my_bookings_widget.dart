import 'package:flutter/material.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/widgets/cancellation_widgets/cancellation_dialog.dart';
import 'package:reeno/widgets/card_ui/card_text_styles.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';

class MyBookingsWidget extends StatelessWidget {
  final Booking booking;
  final isOwner;
  final isCancellable;
  const MyBookingsWidget(this.booking,
      {required this.isOwner, required this.isCancellable, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomizedCard(
      dark: booking.cancelled ? false : true,
      child: Column(
        children: [
          if (booking.cancelled)
            Container(
              width: double.infinity,
              color: const Color.fromRGBO(24, 28, 123, 1),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Cancelled",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          Row(
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
                        height: 10,
                      ),
                      Text(
                        "Court Number ${(booking.courtNo + 1).toString()}",
                        style: CardTextStyles.smallHeadingStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Booking Cost",
                        style: CardTextStyles.smallHeadingStyle(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "₹${booking.amount.toString()}",
                        style: CardTextStyles.bookingWidgetCostStyle(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Payment ID",
                        style: CardTextStyles.smallHeadingStyle(),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        booking.paymentId == null || booking.paymentId == ""
                            ? "-"
                            : booking.paymentId,
                        style: CardTextStyles.bookingWidgetPaymentIDStyle(),
                      ),
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
          if (isOwner)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          "Name : ",
                          style: CardTextStyles.bookingWidgetTimeStyle(),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          booking.userName,
                          style: CardTextStyles.bookingWidgetPaymentIDStyle(),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Row(
                    children: [
                      Text(
                        "UserId : ",
                        style: CardTextStyles.bookingWidgetTimeStyle(),
                      ),
                      Text(
                        booking.userId,
                        style: CardTextStyles.bookingWidgetPaymentIDStyle(),
                      )
                    ],
                  )
                ],
              ),
            ),
          if (isCancellable && !booking.cancelled)
            Container(
              width: double.infinity,
              color: Theme.of(context).errorColor,
              child: TextButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: ((context) {
                        return CancellationDialog(booking);
                      }));
                },
                child: Text(
                  "Cancel Booking",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                // style: ButtonStyle(
                //     backgroundColor: MaterialStateProperty.all(Colors.red)),
              ),
            ),
        ],
      ),
    );
  }
}
