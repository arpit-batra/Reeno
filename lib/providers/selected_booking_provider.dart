import 'package:http/http.dart' as http;
import 'dart:convert';
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
  final int selectedCourtNo;
  final int cancelPolicyDuration;
  double cancellationCharge;
  bool cancelled;
  DateTime selectedStartTime;
  DateTime selectedEndTime;
  double amount;
  String orderId;
  String paymentId;
  String signature;
  Booking _createdBooking;

  SelectedBookingProvider({
    required this.selectedCentreId,
    required this.selectedCentreTitle,
    required this.selectedCentreAddress,
    required this.selectedDateAsString,
    required this.selectedDate,
    required this.selectedCourtNo,
    required this.myUserId,
    required this.myUserName,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.amount,
    required this.orderId,
    required this.paymentId,
    required this.signature,
    required this.cancelPolicyDuration,
    required this.cancellationCharge,
    required this.cancelled,
  }) : _createdBooking = Booking(
          sportCentreId: selectedCentreId,
          sportCentreTitle: selectedCentreTitle,
          sportCentreAddress: selectedCentreAddress,
          date: selectedDateAsString,
          courtNo: selectedCourtNo,
          userId: myUserId,
          userName: myUserName,
          startTime: selectedStartTime,
          endTime: selectedEndTime,
          amount: amount,
          orderId: orderId,
          paymentId: paymentId,
          signature: signature,
          cancelPolicyDuration: cancelPolicyDuration,
          cancellationCharge: cancellationCharge,
          cancelled: cancelled,
        );

  Booking get currBooking {
    return Booking(
      sportCentreId: _createdBooking.sportCentreId,
      sportCentreTitle: _createdBooking.sportCentreTitle,
      sportCentreAddress: _createdBooking.sportCentreAddress,
      userId: _createdBooking.userId,
      userName: _createdBooking.userName,
      date: _createdBooking.date,
      courtNo: _createdBooking.courtNo,
      startTime: _createdBooking.startTime,
      endTime: _createdBooking.endTime,
      amount: _createdBooking.amount,
      orderId: orderId,
      paymentId: paymentId,
      signature: signature,
      cancelPolicyDuration: _createdBooking.cancelPolicyDuration,
      cancellationCharge: _createdBooking.cancellationCharge,
      cancelled: _createdBooking.cancelled,
    );
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

  void setPaymentInfo({orderId, paymentId, signature}) {
    _createdBooking.orderId = orderId;
    _createdBooking.paymentId = paymentId;
    _createdBooking.signature = signature;
    notifyListeners();
  }

  Future<bool> cloudFunctionCallToWriteBooking(String cloudFunctionUrl) async {
    final url = Uri.parse(cloudFunctionUrl);
    final api_response = await http.post(url,
        headers: <String, String>{
          'content-type': 'application/json',
          'orderId': _createdBooking.orderId,
          'paymentId': _createdBooking.paymentId,
          'signature': _createdBooking.signature,
          'user': 'common'
        },
        body: json.encode(_createdBooking));

    print(api_response.statusCode);
    if (api_response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> cloudFunctionCallToWriteBookingForOwner(
      String cloudFunctionUrl) async {
    try {
      final url = Uri.parse(cloudFunctionUrl);
      final api_response = await http.post(url,
          headers: <String, String>{
            'content-type': 'application/json',
            'user': 'owner'
          },
          body: json.encode(_createdBooking));

      print(api_response.statusCode);
      if (api_response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (err) {
      throw err;
    }
  }
}
