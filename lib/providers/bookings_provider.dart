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

  List<Booking> _selectedDateSelectedCentreSelectedCourtBookings = [];
  List<Booking> _currentUserBookings = [];
  List<Booking> _centreBookings = [];

  List<Booking> get selectedDateSelectedCentreSelectedCourtBookings {
    return [..._selectedDateSelectedCentreSelectedCourtBookings];
  }

  List<Booking> get currentUserBookings {
    return [..._currentUserBookings];
  }

  List<Booking> get centreBookings {
    return [..._centreBookings];
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

    _selectedDateSelectedCentreSelectedCourtBookings = todaysBookings;
    // notifyListeners();
  }

  Future<void> fetchCurrentUserBookings() async {
    print("userId $userId");
    final docRef = FirebaseFirestore.instance
        .collection('bookings')
        .withConverter(
            fromFirestore: Booking.fromFirestore,
            toFirestore: (Booking booking, _) => booking.toFirestore());
    final bookings = await docRef.where("userId", isEqualTo: userId).get();
    print("bookings ${bookings.docs}");
    final List<Booking> curUserBookings = [];
    for (final element in bookings.docs) {
      print(element.toString());
      curUserBookings.add(element.data());
    }
    print("Curr bookings $curUserBookings");
    curUserBookings.sort(((a, b) => b.startTime.compareTo(a.startTime)));
    _currentUserBookings = curUserBookings;
  }

  Future<void> fetchCentreBookings(centreId) async {
    print("centreId => $centreId");
    final docRef = FirebaseFirestore.instance
        .collection('bookings')
        .withConverter(
            fromFirestore: Booking.fromFirestore,
            toFirestore: (Booking booking, _) => booking.toFirestore());
    final bookings =
        await docRef.where("sportCentreId", isEqualTo: centreId).get();
    print("bookings ${bookings.docs}");
    final List<Booking> centreBookings = [];
    for (final element in bookings.docs) {
      print(element.toString());
      centreBookings.add(element.data());
    }
    print("Curr bookings $centreBookings");
    centreBookings.sort(((a, b) => b.startTime.compareTo(a.startTime)));
    _centreBookings = centreBookings;
  }
}
