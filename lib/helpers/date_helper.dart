import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateHelper {
  static String getDayOfWeek(DateTime date) {
    final day = date.weekday;
    switch (day) {
      case 1:
        return "MON";
      case 2:
        return "TUE";
      case 3:
        return "WED";
      case 4:
        return "THR";
      case 5:
        return "FRI";
      case 6:
        return "SAT";
      case 7:
        return "SUN";
      default:
        return "NAN";
    }
  }

  static int getdayOfMonth(DateTime date) {
    return date.day;
  }

  static String getMonth(DateTime date) {
    final month = date.month;
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
      default:
        return "NAN";
    }
  }

  static String getMonthShort(DateTime date) {
    final month = date.month;
    switch (month) {
      case 1:
        return "JAN";
      case 2:
        return "FEB";
      case 3:
        return "MAR";
      case 4:
        return "APR";
      case 5:
        return "MAY";
      case 6:
        return "JUN";
      case 7:
        return "JUL";
      case 8:
        return "AUG";
      case 9:
        return "SEP";
      case 10:
        return "OCT";
      case 11:
        return "NOV";
      case 12:
        return "DEC";
      default:
        return "NAN";
    }
  }

  static String getReadableTime(int index) {
    if (index == 24) return "0 am";
    return ("${index % 12 != 0 ? index % 12 : 12} ${index / 12 < 1 ? "am" : "pm"}");
  }

  static double getDurationHeight(
      DateTime startTime, DateTime endTime, double heightPerHour) {
    return (endTime.difference(startTime).inSeconds * heightPerHour) / 3600;
  }

  static double getPlacementFromTop(DateTime startTime, double heightPerHour) {
    final startOfDay = DateTime(startTime.year, startTime.month, startTime.day);
    return (startTime.difference(startOfDay).inSeconds * heightPerHour) / 3600;
  }

  static int _convertTimeOfDayInMinutesOfDay(TimeOfDay tod) {
    return (tod.hour * 60) + tod.minute;
  }

  static Duration convertMinutesToDuration(int mins) {
    return Duration(hours: (mins / 60).floor(), minutes: mins.remainder(60));
  }

  static bool isOverlapping(
      TimeOfDay s1, TimeOfDay e1, TimeOfDay s2, TimeOfDay e2) {
    final s1InMinutes = _convertTimeOfDayInMinutesOfDay(s1);
    final e1InMinutes = _convertTimeOfDayInMinutesOfDay(e1);
    final s2InMinutes = _convertTimeOfDayInMinutesOfDay(s2);
    final e2InMinutes = _convertTimeOfDayInMinutesOfDay(e2);
    if (s2InMinutes > e1InMinutes || s1InMinutes > e2InMinutes) {
      print(
          "s1->$s1InMinutes e1->$e1InMinutes s2->$s2InMinutes e2->$e2InMinutes");
      return false;
    } else {
      return true;
    }
  }

  static Duration differenceBetween(TimeOfDay startTime, TimeOfDay endTime) {
    return convertMinutesToDuration(_convertTimeOfDayInMinutesOfDay(endTime) -
        _convertTimeOfDayInMinutesOfDay(startTime));
  }

  static String durationInString(Duration duration) {
    return "${duration.inHours}hrs ${duration.inMinutes - (duration.inHours * 60)}mins";
  }

  static double costForDuration(Duration duration, double hourlyRate) {
    return (duration.inHours +
            ((duration.inMinutes - (duration.inHours * 60)) / 60)) *
        hourlyRate;
  }

  static String dateTimeToTimeOfDayInString(DateTime dateTime) {
    var formatter = DateFormat("jm");
    // return "${dateTime.}:${dateTime.minute.}";
    return formatter.format(dateTime);
  }

  static bool firstDateBeforeSecond(DateTime d1, DateTime d2) {
    if (d1.year < d2.year) {
      return true;
    }
    if (d1.year > d2.year) {
      return false;
    }
    if (d1.month < d2.month) {
      return true;
    }
    if (d1.month > d2.month) {
      return false;
    }
    if (d1.day < d2.day) {
      return true;
    }
    return false;
  }

  static bool isT1BeforeT2(TimeOfDay t1, TimeOfDay t2) {
    if (t1.hour < t2.hour) {
      return true;
    }
    if (t1.hour > t2.hour) {
      return false;
    }
    if (t1.minute < t2.minute) {
      return true;
    }
    return false;
  }

  static bool compareDayOfDateTimes(DateTime t1, DateTime t2) {
    if (t1.year == t2.year && t1.month == t2.month && t1.day == t2.day) {
      return true;
    }
    return false;
  }

  static String getReadableDate(String date) {
    final dateInDateTime = DateTime(int.parse(date.substring(0, 4)),
        int.parse(date.substring(5, 7)), int.parse(date.substring(8)));
    return "${dateInDateTime.day} ${getMonth(dateInDateTime)}, ${dateInDateTime.year}";
  }
}
