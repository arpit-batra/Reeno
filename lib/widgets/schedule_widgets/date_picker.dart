import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:reeno/providers/selected_date_provider.dart';
import 'package:reeno/widgets/schedule_widgets/date_box.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({Key? key}) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  int? _selectedIndex;
  DateTime? lastDate;
  DateTime? firstDate;
  int? listLength;
  var _isFirst = true;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirst) {
      _isFirst = false;
      final currDate =
          Provider.of<SelectedDateProvider>(context).selectedDateInDateTime;
      lastDate = currDate.add(const Duration(days: 30));
      firstDate = DateTime(2022, 7, 1);
      listLength = lastDate!.difference(firstDate!).inDays;
      setState(() {
        _selectedIndex = listLength! - 30;
      });
    }
  }

  void onDateBoxTap(index) {
    Provider.of<SelectedDateProvider>(context, listen: false)
        .setSelectedDate(firstDate!.add(Duration(days: index)));
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
