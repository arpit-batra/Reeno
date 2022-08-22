import 'package:flutter/material.dart';
import 'package:reeno/widgets/app_drawer_widgets/support_widget.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';

class SupportCard extends StatelessWidget {
  const SupportCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomizedCard(
      dark: false,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(
              Icons.help_outline,
              color: Colors.white,
              size: 60,
            ),
            const SizedBox(
              width: 20,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Need help with the booking?',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      SupportWidget(context).displaySupportInfo();
                    },
                    label: const Text(
                      'Get Support',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline),
                    ),
                    icon: const Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
