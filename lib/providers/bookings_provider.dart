import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:reeno/models/booking.dart';

class BookingsProvider with ChangeNotifier {
  final String selectedSportCentreId;
  final String selectedDate;
  final int selectedCourtNo;
  final String userId;

  BookingsProvider(this.selectedSportCentreId, this.selectedDate,
      this.selectedCourtNo, this.userId);

  List<Booking> _selectedDateSelectedCentreBookings = [];
  List<Booking> _currentUserBookings = [];

  List<Booking> get selectedDateSelectedCentreBookings {
    return [..._selectedDateSelectedCentreBookings];
  }

  List<Booking> get currentUserBookings {
    return [..._currentUserBookings];
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

  Future<void> fetchCurrentUserBookings() async {
    print("userId $userId");
    final docRef = FirebaseFirestore.instance
        .collection('bookings')
        .withConverter(
            fromFirestore: Booking.fromFirestore,
            toFirestore: (Booking booking, _) => booking.toFirestore());
    final bookings = await docRef
        .where("userId", isEqualTo: userId)
        .orderBy("date", descending: true)
        .get();
    print("bookings ${bookings.docs}");
    final List<Booking> curUserBookings = [];
    for (final element in bookings.docs) {
      print(element.toString());
      curUserBookings.add(element.data());
    }
    print("Curr bookings $curUserBookings");
    _currentUserBookings = curUserBookings;
  }
}
