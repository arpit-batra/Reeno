import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneProvider with ChangeNotifier {
  String? _phoneNumber;

  void setPhoneNumber(String phoneNumberReceived) {
    _phoneNumber = phoneNumberReceived;
    notifyListeners();
  }

  String? get phoneNumber {
    return _phoneNumber;
  }
}
