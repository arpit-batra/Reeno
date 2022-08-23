import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:reeno/helpers/google_authentication.dart';

import 'phone_login_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  ButtonStyle loginScreenButtonStyle() {
    return ButtonStyle(
      minimumSize: MaterialStateProperty.all(const Size(double.infinity, 50)),
      side: MaterialStateProperty.all(
          const BorderSide(color: Colors.black, width: 2)),
      shape: MaterialStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _pageHeading(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome to',
          style: TextStyle(fontSize: 20),
        ),
        Text(
          'Reeno',
          style: TextStyle(
            fontSize: 48,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
            'A place which helps you in booking sports centres with ease'),
      ],
    );
  }

  Widget _loginButtons(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lets Get Started',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 20,
        ),

        //Google Login Button
        TextButton.icon(
          key: const ValueKey('Continue with Google'),
          onPressed: () {
            GoogleAuthentication.signInWithGoogle(context);
          },
          label: const Text(
            'Continue with Google',
            style: TextStyle(color: Colors.black),
          ),
          icon: SvgPicture.asset(
            './assets/google-icon.svg',
            fit: BoxFit.fitHeight,
            height: 32,
          ),
          style: loginScreenButtonStyle(),
        ),

        const SizedBox(
          height: 20,
        ),

        //Phone Login Button
        TextButton.icon(
          key: const ValueKey('Continue with Phone'),
          onPressed: () {
            Navigator.of(context).pushNamed(PhoneLoginScreen.routeName);
          },
          label: const Text(
            'Continue with Phone',
            style: TextStyle(color: Colors.black),
          ),
          icon: const Icon(Icons.phone),
          style: loginScreenButtonStyle(),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pageHeading(context),
              const SizedBox(
                height: 64,
              ),
              _loginButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}
