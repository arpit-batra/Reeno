import 'package:flutter/material.dart';
import 'package:reeno/models/booking.dart';

class SelectedBookingProvider with ChangeNotifier {
  final selectedCentreId;
  final selectedCentreTitle;
  final selectedCentreAddress;
  final selectedDateAsString;
  final DateTime selectedDate;
  final myUserId;
  final myUserName;
  DateTime selectedStartTime;
  DateTime selectedEndTime;
  double amount;
  Booking _createdBooking;

  SelectedBookingProvider(
      {required this.selectedCentreId,
      required this.selectedCentreTitle,
      required this.selectedCentreAddress,
      required this.selectedDateAsString,
      required this.selectedDate,
      required this.myUserId,
      required this.myUserName,
      required this.selectedStartTime,
      required this.selectedEndTime,
      required this.amount})
      : _createdBooking = Booking(
            sportCentreId: selectedCentreId,
            sportCentreTitle: selectedCentreTitle,
            sportCentreAddress: selectedCentreAddress,
            date: selectedDateAsString,
            userId: myUserId,
            userName: myUserName,
            startTime: selectedStartTime,
            endTime: selectedEndTime,
            amount: amount);

  Booking get currBooking {
    return Booking(
        sportCentreId: _createdBooking.sportCentreId,
        sportCentreTitle: _createdBooking.sportCentreTitle,
        sportCentreAddress: _createdBooking.sportCentreAddress,
        userId: _createdBooking.userId,
        userName: _createdBooking.userName,
        date: _createdBooking.date,
        startTime: _createdBooking.startTime,
        endTime: _createdBooking.endTime,
        amount: _createdBooking.amount);
  }

  void setSelectedTime(TimeOfDay startTime, TimeOfDay endTime) {
    _createdBooking.startTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, startTime.hour, startTime.minute);
    _createdBooking.endTime = DateTime(selectedDate.year, selectedDate.month,
        selectedDate.day, endTime.hour, endTime.minute);
    notifyListeners();
  }

  void setAmount(double amountToBePaid) {
    _createdBooking.amount = amountToBePaid;
    notifyListeners();
  }
}
