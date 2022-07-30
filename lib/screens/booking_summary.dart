import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:reeno/providers/selected_booking_provider.dart';
import 'package:reeno/screens/payment_results/after_payment_screen.dart';
import 'package:reeno/widgets/cards/booking_time_widget.dart';
import 'package:reeno/widgets/cards/centre_address_widget.dart';
import 'package:reeno/widgets/cards/payment_widget.dart';

class BookingSummary extends StatefulWidget {
  BookingSummary({Key? key}) : super(key: key);

  static const routeName = "/booking-summary";

  @override
  State<BookingSummary> createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("success");
    Navigator.of(context)
        .pushNamed(AfterPaymentScreen.routeName, arguments: true);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print("failure");
    Navigator.of(context)
        .pushNamed(AfterPaymentScreen.routeName, arguments: false);
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> _createOrder(double amount) async {
    //    String username = 'test';
    // String password = '123£';
    // String basicAuth =
    //     'Basic ' + base64.encode(utf8.encode('$username:$password'));
    // print(basicAuth);

    // Response r = await get(Uri.parse('https://api.somewhere.io'),
    //     headers: <String, String>{'authorization': basicAuth});
    // print(r.statusCode);
    const userName = "rzp_test_rUytAswPqSZROv";
    const secret = "hWBWWJ9Jd1zSHbxm6AVcf62d";
    String basicAuth =
        'Basic ' + base64.encode(utf8.encode('$userName:$secret'));
    print(basicAuth);

    final url = Uri.parse('https://api.razorpay.com/v1/orders');
    final response = await http.post(url,
        headers: <String, String>{
          'authorization': basicAuth,
          'content-type': 'application/json'
        },
        body: json.encode(
            {"amount": amount * 100, "currency": "INR", "receipt": "rtp"}));

    print(json.decode(response.body)['id']);
    final orderId = json.decode(response.body)['id'];
    var options = {
      'key': userName,
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'Reeno',
      'order_id': orderId,
      'description': 'Slot Booking',
      'timeout': 120,
    };
    _razorpay.open(options);
  }

  @override
  Widget build(BuildContext context) {
    final selectedBooking =
        Provider.of<SelectedBookingProvider>(context).currBooking;
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Summary")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  CentreAddressWidget(selectedBooking),
                  const SizedBox(
                    height: 24,
                  ),
                  BookingTimeWidget(selectedBooking),
                  const SizedBox(
                    height: 24,
                  ),
                  PaymentWidget(selectedBooking),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                  onPressed: () {
                    _createOrder(selectedBooking.amount);
                  },
                  child: const Text(
                    "Proceed",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
