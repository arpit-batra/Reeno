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
  bool _loadingState = false;
  final _razorpay = Razorpay();

  @override
  void initState() {
    super.initState();
    print("Booking Summary -> init");
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
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
        .pushNamed(AfterPaymentScreen.routeName, arguments: false)
        .then((value) {
      setState(() {
        _loadingState = false;
      });
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  Future<void> _createOrder(double amount) async {
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
      'amount': amount,
      'name': 'Reeno',
      'order_id': orderId,
      'description': 'Slot Booking',
      'timeout': 120,
    };
    _razorpay.open(options);
    print("Booking Summary -> completed");
  }

  @override
  Widget build(BuildContext context) {
    final selectedBooking =
        Provider.of<SelectedBookingProvider>(context).currBooking;
    return Scaffold(
      appBar: AppBar(title: const Text("Booking Summary")),
      body: Stack(
        children: [
          Padding(
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
                        setState(() {
                          _loadingState = true;
                        });
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
          if (_loadingState)
            Container(
              color: const Color.fromARGB(100, 255, 255, 255),
            ),
          if (_loadingState)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
