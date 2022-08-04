import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';

class SelectedDateProvider with ChangeNotifier {
  DateTime? _selectedDate;
  DateTime? _currDate;

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

  DateTime get currDateInDateTime {
    ////////////////////////////////////////////////
    if (_currDate == null) return DateTime.now();
    ////////////////////////////////////////////////
    return DateTime.parse(_currDate!.toIso8601String());
  }

  Future<DateTime> setSelectedDateAsCurrDate() async {
    _selectedDate = await NTP.now();
    _currDate = _selectedDate;
    return _selectedDate!;
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
