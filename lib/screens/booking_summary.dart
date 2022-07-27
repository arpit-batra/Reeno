import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/providers/selected_booking_provider.dart';
import 'package:reeno/widgets/customized_card.dart';

class BookingSummary extends StatelessWidget {
  const BookingSummary({Key? key}) : super(key: key);

  static const routeName = "/booking-summary";

  TextStyle headingStyle() {
    return const TextStyle(color: Colors.white, fontSize: 16);
  }

  TextStyle primaryInfoStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);
  }

  TextStyle secondaryInfoStyle() {
    return const TextStyle(color: Colors.white, fontSize: 16);
  }

  @override
  Widget build(BuildContext context) {
    final selectedBooking =
        Provider.of<SelectedBookingProvider>(context).currBooking;
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Summary")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CustomizedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Place of Booking",
                            style: headingStyle(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            selectedBooking.sportCentreTitle,
                            style: primaryInfoStyle(),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            selectedBooking.sportCentreAddress,
                            style: secondaryInfoStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomizedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Time of Booking",
                            style: headingStyle(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            selectedBooking.date,
                            style: primaryInfoStyle(),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            "${DateHelper.DateTimeToTimeOfDayInString(selectedBooking.startTime)} - ${DateHelper.DateTimeToTimeOfDayInString(selectedBooking.endTime)}",
                            style: secondaryInfoStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomizedCard(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment Summary",
                            style: headingStyle(),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Grand Total",
                                style: primaryInfoStyle(),
                              ),
                              Text(
                                selectedBooking.amount.toString(),
                                style: primaryInfoStyle(),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                  onPressed: () {},
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
