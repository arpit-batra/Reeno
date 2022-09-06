import 'package:flutter/services.dart';
import 'package:reeno/app_config.dart';
import 'package:reeno/main.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  var configuredApp = AppConfig(
    appName: 'Reeno',
    flavorName: 'prod',
    defaultImageLink: "gs://reeno-5dce8.appspot.com/default_prof_pic.jpeg",
    createBookingCloudFunctionUrl:
        'https://us-central1-reeno-5dce8.cloudfunctions.net/function-1',
    cancelBookingCloudFunctionUrl: '',
    rzpUserName: "rzp_live_58blDm1nF7ATAo",
    rzpSecret: "OLmrqJved40lB70kD2nZQAf4",
    child: MyApp(),
  );
  runApp(configuredApp);
}
