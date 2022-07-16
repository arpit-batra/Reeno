import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/widgets/app_drawer.dart';
import 'package:reeno/widgets/schedule_widgets/date_picker.dart';
import 'package:reeno/widgets/schedule_widgets/dates_strip.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);
  static const routeName = "/schedule-screen";

  @override
  Widget build(BuildContext context) {
    final centreMeta = Provider.of<SportCentresProvider>(context, listen: false)
        .selectedCentreMeta;
    return Scaffold(
      appBar: AppBar(title: Text(centreMeta.title)),
      // appBar: AppBar(title: Text("shdfksjhdf")),
      drawer: const AppDrawer(),
      body: Column(children: <Widget>[
        const SizedBox(
          height: 100,
          width: double.infinity,
          child: DatesStrip(),
        ),
        Container(
          height: 300,
          color: Colors.blue,
        ),
        ElevatedButton(onPressed: () {}, child: Text('continue'))
      ]),
    );
  }
}
