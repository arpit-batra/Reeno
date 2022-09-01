import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:reeno/providers/selected_booking_provider.dart';
import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/screens/booking_summary.dart';
import 'package:reeno/widgets/card_ui/customized_card.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:provider/provider.dart';
import 'package:reeno/helpers/date_helper.dart';
import 'package:reeno/providers/bookings_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/models/booking.dart';

class TimeSelector extends StatefulWidget {
  const TimeSelector({Key? key}) : super(key: key);

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  var _startTime = const TimeOfDay(hour: 8, minute: 0);
  var _endTime = const TimeOfDay(hour: 9, minute: 0);
  static const Color darkPrimary = Color.fromRGBO(24, 28, 123, 1);

  String _validTimeRange() {
    final selectedDateProvider = Provider.of<SelectedDateProvider>(context);

    final currDate = selectedDateProvider.currDateInDateTime;
    final selectedDate = selectedDateProvider.selectedDateInDateTime;

    if (DateHelper.compareDayOfDateTimes(selectedDate, currDate) &&
        DateHelper.isT1BeforeT2(_startTime, TimeOfDay.fromDateTime(currDate))) {
      return "Selected slot is in the past";
    }

    List<Booking> bookings = Provider.of<BookingsProvider>(context)
        .selectedDateSelectedCentreSelectedCourtBookings;
    for (var element in bookings) {
      if (DateHelper.isOverlapping(TimeOfDay.fromDateTime(element.startTime),
          TimeOfDay.fromDateTime(element.endTime), _startTime, _endTime)) {
        return "Selected slot clashes with someone else";
      }
    }
    return "";
  }

  Widget _createTimeDisplayBox(String label, TimeOfDay time) {
    return Column(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: darkPrimary, fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            time.format(context),
            textAlign: TextAlign.center,
            style: const TextStyle(color: darkPrimary, fontSize: 32),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedSportCentre =
        Provider.of<SportCentresProvider>(context).selectedSportCentre;
    var _duration = DateHelper.differenceBetween(_startTime, _endTime);
    return Center(
      child: Container(
        width: 350,
        height: 540,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                          flex: 7,
                          child:
                              _createTimeDisplayBox("Start Time", _startTime)),
                      Container(
                        width: 2,
                        height: 60,
                        color: Theme.of(context).primaryColor.withOpacity(0.4),
                      ),
                      Expanded(
                        flex: 7,
                        child: _createTimeDisplayBox("End Time", _endTime),
                      )
                    ],
                  ),
                ),
                TimeRangePicker(
                  padding: 25,
                  hideButtons: true,
                  hideTimes: true,
                  strokeColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  handlerColor: _validTimeRange().isEmpty
                      ? darkPrimary
                      : Theme.of(context).errorColor,
                  backgroundWidget: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(135)),
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      height: 268,
                      width: 268,
                    ),
                  ),
                  interval: selectedSportCentre.leastInterval,
                  minDuration: selectedSportCentre.minimumTime,
                  disabledTime: TimeRange(
                      startTime: selectedSportCentre.closingTime,
                      endTime: selectedSportCentre.openingTime),
                  ticks: 24,
                  ticksOffset: -20,
                  ticksWidth: 3,
                  ticksLength: 10,
                  ticksColor: Colors.white,
                  snap: true,
                  selectedColor: Colors.black,
                  start: _startTime,
                  end: _endTime,
                  onStartChange: (start) {
                    setState(() {
                      _startTime = start;
                    });
                  },
                  onEndChange: (end) {
                    setState(() {
                      _endTime = end;
                    });
                  },
                ),
                if (_validTimeRange().isNotEmpty)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _validTimeRange(),
                      style: TextStyle(color: Theme.of(context).errorColor),
                    ),
                  ),
                const SizedBox(
                  height: 6,
                ),
                CustomizedCard(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Duration : ${DateHelper.durationInString(_duration)}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 14),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Cost : ${DateHelper.costForDuration(_duration, selectedSportCentre.hourlyRate)}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 18),
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: _validTimeRange().isEmpty
                                ? () {
                                    print(_startTime);
                                    print(_endTime);
                                    Provider.of<SelectedBookingProvider>(
                                            context,
                                            listen: false)
                                        .setSelectedTime(_startTime, _endTime);
                                    Provider.of<SelectedBookingProvider>(
                                            context,
                                            listen: false)
                                        .setAmount(DateHelper.costForDuration(
                                            _duration,
                                            selectedSportCentre.hourlyRate));
                                    Navigator.of(context)
                                        .pushNamed(BookingSummary.routeName);
                                  }
                                : null,
                            child: const Text(
                              "Continue",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
