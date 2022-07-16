import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:reeno/widgets/schedule_widgets/date_picker.dart';

class DatesStrip extends StatelessWidget {
  const DatesStrip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: NTP.now(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final currDate = snapshot.data as DateTime;
            return DatePicker(currDate: currDate);
          } else {
            return const CardLoading(height: 60);
          }
        });
  }
}
