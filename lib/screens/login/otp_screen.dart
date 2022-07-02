import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:reeno/widgets/login_widgets/resend_widget.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp-screen';

  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  var phoneNumber;
  bool _firstLoad = true;
  final _otpTextController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_firstLoad) {
      phoneNumber = ModalRoute.of(context)!.settings.arguments;
    }
    _firstLoad = false;
  }

  void submitOtp() {
    print(_otpTextController.text);
    Navigator.of(context).pop(_otpTextController.text);
  }

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
                const Expanded(flex: 4, child: SizedBox()),
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
                  child: Text('Enter the OTP below'),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: PinCodeTextField(
                    autoFocus: true,
                    appContext: context,
                    length: 6,
                    onChanged: (value) {},
                    controller: _otpTextController,
                    obscureText: true,
                    blinkWhenObscuring: true,
                    pinTheme: PinTheme(
                      activeColor: Theme.of(context).primaryColor,
                      inactiveColor: Theme.of(context).primaryColor,
                      selectedColor: Colors.black,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      const Text('Did not receive a message?'),
                      ResendWidget(phoneNumber),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: submitOtp,
                    child: const Text('Submit'),
                  ),
                ),
                const Expanded(flex: 20, child: SizedBox())
              ],
            ),
          ),
        ));
  }
}
