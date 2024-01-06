import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Map<String, dynamic>? paymentIntent;
  void makePayment() async {
    try {
      paymentIntent = await createPaymentIntent();
      var gpay = const PaymentSheetGooglePay(
          merchantCountryCode: "US", currencyCode: "US", testEnv: true);
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              merchantDisplayName: 'Talha',
              googlePay: gpay,
              style: ThemeMode.dark));

      displayPaymentSheet();
    } catch (e) {}
  }

  void displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      print('Done');
    } catch (e) {
      print('Failed');
    }
  }

  createPaymentIntent() async {
    try {
      Map<String, dynamic> body = {"amount": "1000", "currency": "USD"};
      http.Response response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            "Authorization":
                "Bearer sk_test_51JCiBhBEJyVxZuHvy7nISzbYKYTYJvF72YeNdMP0nj3B3ZjqEFKdP7bWakt75Np1QdL6sOWp0beg6xfHJ0NyeFdD00LxSjgXa3",
            "Content-Type": 'application/x-www-form-urlencoded'
          });
      return json.decode(response.body);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              makePayment();
            },
            child: Text('Checkout Button')),
      ),
    );
  }
}
