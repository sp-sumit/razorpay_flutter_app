import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_flutter_app/Model/pay_model.dart';

final payHandler = StateNotifierProvider<PayHandler, Function>(
  (ref) {
    return PayHandler();
  },
);

class PayHandler extends StateNotifier<Function> {
  PayHandler() : super(PayModel().initState());

  final _razorpay = Razorpay();
  void openCheckout() async {
    var options = {
      'key': 'fZjNYgHYivgczqDESUNzw5de',
      'amount': 25,
      'name': 'Sumit',
      'description': 'Payment',
      'prefill': {'contact': '1234567890', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e);
    }
  }
}
