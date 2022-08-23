import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/widgets/loading_widget.dart';
import 'package:reeno/providers/bookings_provider.dart';
import 'package:reeno/widgets/schedule_widgets/schedule_widget.dart';

class DaySchedule extends StatefulWidget {
  const DaySchedule({Key? key}) : super(key: key);

  @override
  State<DaySchedule> createState() => _DayScheduleState();
}

class _DayScheduleState extends State<DaySchedule> {
  // bool _isFirstRun = true;
  // late Future<void> _fetchBookings;

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   if (_isFirstRun) {
  //     _isFirstRun = false;
  //     _fetchBookings =
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final bookingsProvider = Provider.of<BookingsProvider>(context);
    print("rebuilding day schedule");
    return FutureBuilder(
      future: bookingsProvider
          .fetchSelectedDateSelectedCentreSelectedCourtBookings(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return Center(
            child: Image.asset('./assets/3828556.jpg'),
          );
        } else {
          return ScheduleWidget();
        }
      },
    );
  }
}
