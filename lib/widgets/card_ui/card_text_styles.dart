import 'package:flutter/material.dart';

class CardTextStyles {
  static TextStyle headingStyle() {
    return const TextStyle(color: Colors.white, fontSize: 16);
  }

  static TextStyle primaryInfoStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold);
  }

  static TextStyle secondaryInfoStyle() {
    return const TextStyle(color: Colors.white, fontSize: 16);
  }

  static TextStyle smallHeadingStyle() {
    return const TextStyle(color: Colors.white, fontSize: 14);
  }

  static TextStyle bookingWidgetCostStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500);
  }

  static TextStyle bookingWidgetPaymentIDStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500);
  }

  static TextStyle bookingWidgetDateStyle() {
    return const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600);
  }

  static TextStyle bookingWidgetTimeStyle() {
    return const TextStyle(color: Colors.white, fontSize: 14);
  }
}
