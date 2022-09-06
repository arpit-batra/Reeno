import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:reeno/app_config.dart';
import 'package:reeno/main.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  var configuredApp = AppConfig(
    appName: 'Reeno Dev',
    flavorName: 'dev',
    defaultImageLink: "gs://reenodev.appspot.com/default_prof_pic.jpeg",
    createBookingCloudFunctionUrl:
        'https://us-central1-reenodev.cloudfunctions.net/createBooking',
    cancelBookingCloudFunctionUrl:
        'https://us-central1-reenodev.cloudfunctions.net/cancelBooking',
    rzpUserName: "rzp_test_rUytAswPqSZROv",
    rzpSecret: "hWBWWJ9Jd1zSHbxm6AVcf62d",
    child: (MyApp()),
  );

  runApp(configuredApp);
}
