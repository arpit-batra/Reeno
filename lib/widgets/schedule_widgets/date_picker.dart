import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';
import 'package:ntp/ntp.dart';
import 'package:reeno/widgets/schedule_widgets/date_box.dart';

class DatePicker extends StatefulWidget {
  final DateTime currDate;
  const DatePicker({required this.currDate, Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int? _selectedIndex;
  DateTime? lastDate;
  DateTime? firstDate;
  int? listLength;

  @override
  void initState() {
    super.initState();
    lastDate = widget.currDate.add(Duration(days: 30));
    firstDate = DateTime(2022, 7, 1);
    listLength = lastDate!.difference(firstDate!).inDays;
    setState(() {
      _selectedIndex = listLength! - 30;
    });
  }

  void onDateBoxTap(index) {
    print('Tap detected $index');

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: ((context, index) => DateBox(
            isSelected: index == _selectedIndex ? true : false,
            date: firstDate!.add(Duration(days: index)),
            onTap: () {
              onDateBoxTap(index);
            },
          )),
      itemCount: listLength,
      scrollDirection: Axis.horizontal,
      controller: ScrollController(
          initialScrollOffset:
              (listLength! - 30) * (MediaQuery.of(context).size.width / 6)),
    );
  }
}
