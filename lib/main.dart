import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:reeno/providers/phone_provider.dart';
import 'package:reeno/providers/sport_centres_provider.dart';
import 'package:reeno/providers/user_provider.dart';
import 'package:reeno/screens/centre_info_screen.dart';
import 'package:reeno/screens/schedule_screen.dart';
import 'package:reeno/screens/sport_centre_list_screen.dart';
import 'package:reeno/screens/login/get_user_info_screen.dart';
import 'package:reeno/screens/login/login_screen.dart';
import 'package:reeno/screens/login/otp_screen.dart';
import 'package:reeno/screens/login/phone_login_screen.dart';
import 'package:reeno/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

OutlineInputBorder textFieldBorderTheme() {
  return OutlineInputBorder(
      borderSide: const BorderSide(
        width: 2,
        color: Color.fromARGB(1023, 87, 93, 251),
      ),
      borderRadius: BorderRadius.circular(16));
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: PhoneProvider()),
        ChangeNotifierProvider.value(value: UserProvider()),
        ChangeNotifierProvider.value(value: SportCentresProvider())
      ],
      child: MaterialApp(
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
            enabledBorder: textFieldBorderTheme(),
            focusedBorder: textFieldBorderTheme(),
            disabledBorder: textFieldBorderTheme(),
          ),
        ),
        home: FutureBuilder(
          future: _fbApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print('Unable to initialize firebaseApp');
              print(snapshot.error);
              return const Text('Unable to initialize firebaseApp');
            } else if (snapshot.hasData) {
              return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    print('POPO Loading Splash Screen');
                    return SplashScreen();
                  }
                  if (snapshot.hasData) {
                    while (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                    print("POPO Loading Centre List");

                    return SportCentreListScreen();
                    // return ChangeNotifierProvider(
                    //   create: ((context) => SportCentresProvider()),
                    //   child: SportCentreListScreen(),
                    // );
                  }
                  print("POPO Loding Sign in");
                  return SignInScreen();
                  // SignInScreen();
                },
              );
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
          GetUserInfoScreen.routeName: (context) => GetUserInfoScreen(),
          CentreInfoScreen.routeName: (context) => CentreInfoScreen(),
          ScheduleScreen.routeName: (context) => ScheduleScreen(),
        },
      ),
    );
  }
}
