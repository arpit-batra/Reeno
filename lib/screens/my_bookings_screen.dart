import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/bookings_provider.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/screens/loading_screen.dart';
import 'package:reeno/models/booking.dart';
import 'package:reeno/widgets/cards/my_bookings_widget.dart';

class MyBookingsScreen extends StatelessWidget {
  const MyBookingsScreen({Key? key}) : super(key: key);
  static const routeName = '/my-bookings';

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final isNotAnOwner =
        userProvider.user!.owner == null || userProvider.user!.owner == false;
    print("user => ${userProvider.user!.owner}");
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Bookings"),
      ),
      body: FutureBuilder(
          future: isNotAnOwner
              ? Provider.of<BookingsProvider>(context, listen: false)
                  .fetchCurrentUserBookings()
              : Provider.of<BookingsProvider>(context, listen: false)
                  .fetchCentreBookings(userProvider.user!.centreId),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Image.asset('./assets/3828556.jpg'),
              );
            } else {
              final listOfBookings = userProvider.user!.owner == null ||
                      userProvider.user!.owner == false
                  ? Provider.of<BookingsProvider>(context, listen: false)
                      .currentUserBookings
                  : Provider.of<BookingsProvider>(context, listen: false)
                      .centreBookings;
              return ListView.builder(
                  itemCount: listOfBookings.length,
                  itemBuilder: ((context, index) {
                    final booking = listOfBookings[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isNotAnOwner
                          ? MyBookingsWidget(booking, false)
                          : MyBookingsWidget(booking, true),
                    );
                  }));
            }
          })),
    );
  }
}
