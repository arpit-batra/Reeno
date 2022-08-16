import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/bookings_provider.dart';
import 'package:reeno/screens/loading_screen.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/widgets/cards/my_bookings_widget.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/my-bookings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Bookings"),
      ),
      body: FutureBuilder(
          future: Provider.of<BookingsProvider>(context, listen: false)
              .fetchCurrentUserBookings(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else {
              final listOfBookings =
                  Provider.of<BookingsProvider>(context, listen: false)
                      .currentUserBookings;
              return ListView.builder(
                  itemCount: listOfBookings.length,
                  itemBuilder: ((context, index) {
                    final booking = listOfBookings[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MyBookingsWidget(booking),
                    );
                  }));
            }
          })),
    );
  }
}
