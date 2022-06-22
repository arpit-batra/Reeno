import 'package:flutter/material.dart';

class OtpScreen extends StatelessWidget {
  static const routeName = '/otp-screen';

  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _otpTextController = TextEditingController();

    void submitOtp() {
      Navigator.of(context).pop(_otpTextController.text);
    }

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
                    keyboardType: TextInputType.number,
                    obscureText: true,
                    controller: _otpTextController,
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
                    onPressed: submitOtp,
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
