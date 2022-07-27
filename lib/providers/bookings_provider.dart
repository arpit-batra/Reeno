import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/booking.dart';

class BookingsProvider with ChangeNotifier {
  final String selectedSportCentreId;
  final String selectedDate;

  BookingsProvider(this.selectedSportCentreId, this.selectedDate);

  List<Booking> _selectedDateSelectedCentreBookings = [];

  List<Booking> get selectedDateSelectedCentreBookings {
    return [..._selectedDateSelectedCentreBookings];
  }

  Future<void> fetchSelectedDateSelectedCentreBookings() async {
    print("Sport Centre Id ${selectedSportCentreId}");
    print(" Selected Date ${selectedDate}");
    // print("Bookings Provider");
    final docRef = FirebaseFirestore.instance
        .collection('bookings')
        .withConverter(
            fromFirestore: Booking.fromFirestore,
            toFirestore: (Booking booking, _) => booking.toFirestore());
    final bookings = await docRef
        .where("sportCentreId", isEqualTo: selectedSportCentreId)
        .where("date", isEqualTo: selectedDate)
        .get();
    final List<Booking> todaysBookings = [];
    for (final element in bookings.docs) {
      todaysBookings.add(element.data());
    }

    _selectedDateSelectedCentreBookings = todaysBookings;
    // notifyListeners();
  }
}
