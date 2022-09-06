import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ntp/ntp.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/providers/bookings_provider.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/screens/loading_screen.dart';
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
        //Getting current time
        future: NTP.now(),
        builder: ((context, ntpSnapshot) {
          if (ntpSnapshot.connectionState == ConnectionState.waiting) {
            return LoadingScreen();
          } else if (ntpSnapshot.hasError) {
            return Center(
              child: Image.asset('./assets/3828556.jpg'),
            );
          } else {
            print(ntpSnapshot.data);
            return FutureBuilder(
                //Fetching the bookings
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
                    //getting bookings from the provider
                    final listOfBookings = userProvider.user!.owner == null ||
                            userProvider.user!.owner == false
                        ? Provider.of<BookingsProvider>(context, listen: false)
                            .currentUserBookings
                        : Provider.of<BookingsProvider>(context, listen: false)
                            .centreBookings;
                    //if list of bookings is empty
                    if (listOfBookings.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long,
                              size: 100,
                              color: Colors.grey[600],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "You don't have any bookings yet",
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        ),
                      );
                    }
                    //if list of bookings is not empty
                    else {
                      return ListView.builder(
                          itemCount: listOfBookings.length,
                          itemBuilder: ((context, index) {
                            final booking = listOfBookings[index];
                            //calculating if this booking is cancellable or not
                            final cancellable = isNotAnOwner
                                ? DateHelper.isCancellable(
                                    ntpSnapshot.data as DateTime,
                                    booking.startTime,
                                    booking.cancelPolicyDuration)
                                : DateHelper.isCancellable(
                                    ntpSnapshot.data as DateTime,
                                    booking.startTime,
                                    0);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: isNotAnOwner
                                  ? MyBookingsWidget(
                                      booking,
                                      isOwner: false,
                                      isCancellable: cancellable,
                                    )
                                  : MyBookingsWidget(
                                      booking,
                                      isOwner: true,
                                      isCancellable: cancellable,
                                    ),
                            );
                          }));
                    }
                  }
                }));
          }
        }),
      ),
    );
  }
}
