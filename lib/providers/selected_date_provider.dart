import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class SelectedDateProvider with ChangeNotifier {
  DateTime? _selectedDate;

  String get selectedDateInString {
    // if (_selectedDate == null) {
    //   _selectedDate = await NTP.now();
    //   notifyListeners();
    // }

    var formatter = DateFormat("dd-MM-yyyy");
    if (_selectedDate == null) return "";
    return formatter.format(_selectedDate!);
    // return DateTime.parse(_selectedDate!.toIso8601String());
  }

  DateTime get selectedDateInDateTime {
    ////////////////////////////////////////////////
    if (_selectedDate == null) return DateTime.now();
    ////////////////////////////////////////////////
    return DateTime.parse(_selectedDate!.toIso8601String());
  }

  Future<void> setSelectedDateAsCurrDate() async {
    _selectedDate = await NTP.now();
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
