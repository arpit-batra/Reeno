import 'package:flutter/material.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';

class RefundCard extends StatelessWidget {
  const RefundCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomizedCard(
      dark: false,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Text(
          "Money Deducted will be refunded in your account within 5-7 business days.",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              height: 1.5,
              wordSpacing: 1.5),
        ),
      ),
    );
  }
}
