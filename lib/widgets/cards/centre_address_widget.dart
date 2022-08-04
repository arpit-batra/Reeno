import 'package:flutter/material.dart';
import 'package:reeno/widgets/card_ui/card_text_styles.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';
import 'package:reeno/models/booking.dart';

class CentreAddressWidget extends StatelessWidget {
  final Booking selectedBooking;
  final bool dark;
  const CentreAddressWidget(this.selectedBooking, {this.dark = true, Key? key})
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
              "Place of Booking",
              style: CardTextStyles.headingStyle(),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              selectedBooking.sportCentreTitle,
              style: CardTextStyles.primaryInfoStyle(),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              "Court Number ${selectedBooking.courtNo + 1}",
              style: CardTextStyles.secondaryInfoStyle(),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              selectedBooking.sportCentreAddress,
              style: CardTextStyles.secondaryInfoStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
