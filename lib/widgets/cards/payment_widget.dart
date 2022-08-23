import 'package:flutter/material.dart';
import 'package:reeno/widgets/card_ui/card_text_styles.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';
import 'package:reeno/models/booking.dart';

class PaymentWidget extends StatelessWidget {
  final Booking selectedBooking;
  const PaymentWidget(this.selectedBooking, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomizedCard(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Summary",
              style: CardTextStyles.headingStyle(),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grand Total",
                  style: CardTextStyles.primaryInfoStyle(),
                ),
                Text(
                  selectedBooking.amount.toString(),
                  style: CardTextStyles.primaryInfoStyle(),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
