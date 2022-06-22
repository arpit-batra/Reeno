import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:reeno/helpers/phone_authentication.dart';

class PhoneLoginScreen extends StatefulWidget {
  static const routeName = '/phoneLogin';
  const PhoneLoginScreen({Key? key}) : super(key: key);

  @override
  _PhoneLoginScreenState createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 4,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Text(
                      'We’ll send an OTP to the given phone number for verification'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    controller: _phoneTextController,
                    decoration: const InputDecoration(
                      labelText: 'Phone Number',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      PhoneAuthentication.verifyPhone(
                          _phoneTextController.text, context);
                    },
                    child: const Text('Register'),
                  ),
                ),
                const Expanded(flex: 20, child: SizedBox())
              ],
            ),
          ),
        ));
  }
}
