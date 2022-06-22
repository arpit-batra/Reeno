import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:reeno/screens/login_screen.dart';
import 'package:reeno/screens/otp_screen.dart';
import 'package:reeno/screens/phone_login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const Map<int, Color> themeColor = {
      50: Color.fromRGBO(87, 93, 251, .1),
      100: Color.fromRGBO(87, 93, 251, .2),
      200: Color.fromRGBO(87, 93, 251, .3),
      300: Color.fromRGBO(87, 93, 251, .4),
      400: Color.fromRGBO(87, 93, 251, .5),
      500: Color.fromRGBO(87, 93, 251, .6),
      600: Color.fromRGBO(87, 93, 251, .7),
      700: Color.fromRGBO(87, 93, 251, .8),
      800: Color.fromRGBO(87, 93, 251, .9),
      900: Color.fromRGBO(87, 93, 251, 1),
    };
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF575DFB, themeColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(10)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(1023, 87, 93, 251),
              ),
              borderRadius: BorderRadius.circular(16)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Color.fromARGB(1023, 87, 93, 251),
              ),
              borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: FutureBuilder(
        future: _fbApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print('Unable to initialize firebaseApp');
            return const Text('Unable to initialize firebaseApp');
          } else if (snapshot.hasData) {
            return SignInScreen();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      routes: {
        PhoneLoginScreen.routeName: (context) => PhoneLoginScreen(),
        OtpScreen.routeName: (context) => OtpScreen(),
      },
    );
  }
}
