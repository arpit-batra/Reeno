import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/booking.dart';

class BookingsProvider with ChangeNotifier {
  final String selectedSportCentreId;
  final String selectedDate;
  final int selectedCourtNo;

  BookingsProvider(
      this.selectedSportCentreId, this.selectedDate, this.selectedCourtNo);

  List<Booking> _selectedDateSelectedCentreBookings = [];

  List<Booking> get selectedDateSelectedCentreBookings {
    return [..._selectedDateSelectedCentreBookings];
  }

  Future<void> fetchSelectedDateSelectedCentreSelectedCourtBookings() async {
    print("Sport Centre Id $selectedSportCentreId");
    print("Selected Date $selectedDate");
    print("Selected Court No $selectedCourtNo");
    // print("Bookings Provider");
    final docRef = FirebaseFirestore.instance
        .collection('bookings')
        .withConverter(
            fromFirestore: Booking.fromFirestore,
            toFirestore: (Booking booking, _) => booking.toFirestore());
    final bookings = await docRef
        .where("sportCentreId", isEqualTo: selectedSportCentreId)
        .where("date", isEqualTo: selectedDate)
        .where("courtNo", isEqualTo: selectedCourtNo)
        .get();
    final List<Booking> todaysBookings = [];
    for (final element in bookings.docs) {
      todaysBookings.add(element.data());
    }

    _selectedDateSelectedCentreBookings = todaysBookings;
    // notifyListeners();
  }
}
