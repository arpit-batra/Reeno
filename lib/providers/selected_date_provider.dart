import 'package:flutter/material.dart';

class SelectedDateProvider with ChangeNotifier {
  DateTime? _selectedDate;

  DateTime get selectedDate {
    return DateTime.parse(_selectedDate!.toIso8601String());
  }

  void setSelectedDate(DateTime date) {
    _selectedDate = date;
    notifyListeners();
  }
}
