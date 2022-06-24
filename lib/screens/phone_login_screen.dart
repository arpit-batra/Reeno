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
  var _loadingState = false;
  var _invalidPhoneNumber = false;

//Submit Button Handler
  void _submitPhoneNumber() {
    if (_phoneTextController.text.length != 10) {
      setState(() {
        _invalidPhoneNumber = true;
      });
      return;
    }
    setState(() {
      _invalidPhoneNumber = false;
    });
    PhoneAuthentication.verifyPhone('+91${_phoneTextController.text}', context);
    setState(() {
      _loadingState = true;
    });
  }

//Page Widgets is sequence from top to bottom

//Back Button
  Widget _backButton() {
    return Expanded(
      flex: 4,
      child: IconButton(
        alignment: Alignment.centerLeft,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

//Displays page heading
  List<Widget> _pageHeading() {
    return [
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
    ];
  }

  //TextField to get Phone Number
  Widget _phoneNumberInputField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: const Center(
              child: Text(
                '+91',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              enabled: _loadingState ? false : true,
              keyboardType: TextInputType.phone,
              controller: _phoneTextController,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                errorText: _invalidPhoneNumber
                    ? 'Phone Number should have 10 digits'
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _loadingState
            ? null
            : () {
                _submitPhoneNumber();
              },
        child: const Text('Register'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _backButton(),
                  ..._pageHeading(),
                  _phoneNumberInputField(),
                  _registerButton(),
                  if (MediaQuery.of(context).orientation ==
                      Orientation.portrait)
                    const Expanded(flex: 20, child: SizedBox())
                ],
              ),
            ),
            if (_loadingState)
              Container(
                color: const Color.fromARGB(100, 255, 255, 255),
              ),
            if (_loadingState)
              const Center(
                child: CircularProgressIndicator(),
              ),
          ]),
        ));
  }
}
