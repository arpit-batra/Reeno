import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/booking.dart';

class BookingsProvider with ChangeNotifier {
  List<Booking> _oneDateBookings = [];

  Future<List<Booking>> fetchTodaysBookingsForCentre(
      String date, String sportCentreId) async {
    final docRef = FirebaseFirestore.instance
        .collection('bookings')
        .withConverter(
            fromFirestore: Booking.fromFirestore,
            toFirestore: (Booking booking, _) => booking.toFirestore());
    final bookings = await docRef
        .where("sportCentreId", isEqualTo: sportCentreId)
        .where("date", isEqualTo: date)
        .get();
    final List<Booking> todaysBookings = [];
    for (final element in bookings.docs) {
      todaysBookings.add(element.data());
    }

    _oneDateBookings = todaysBookings;
    notifyListeners();
    return todaysBookings;
  }
}
