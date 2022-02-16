import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:razorpay_flutter_app/Model/pay_model.dart';
import 'package:http/http.dart' as http;

final payHandler = StateNotifierProvider<PayHandler, Function>(
  (ref) {
    return PayHandler();
  },
);

class PayHandler extends StateNotifier<Function> {
  PayHandler() : super(() {});

  final _razorpay = Razorpay();

  Future<String> generateOrderId(num amount) async {
    const key = 'rzp_test_xEXFEMh20xJ65O';
    const secret = 'fZjNYgHYivgczqDESUNzw5de';
    var authn = 'Basic ' + base64Encode(utf8.encode('$key:$secret'));

    var headers = {
      'content-type': 'application/json',
      'Authorization': authn,
    };

    var data =
        '{ "amount": $amount, "currency": "INR", "receipt": "receipt#R1", "payment_capture": 1 }'; // as per my experience the receipt doesn't play any role in helping you generate a certain pattern in your Order ID!!
    Uri url = Uri.parse('https://api.razorpay.com/v1/orders');
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode != 200) {
      print(json.decode(res.body));
      return 'false';
    }

    return json.decode(res.body)['id'].toString();
  }

  void openCheckout(String orderId) {
    var options = {
      'key': 'rzp_test_xEXFEMh20xJ65O', //'fZjNYgHYivgczqDESUNzw5de',
      'amount': 25.00,
      'name': 'Sumit',
      'description': 'Payment',
      'order_id': orderId,
      'prefill': {'contact': '1234567890', 'email': 'test@razorpay.com'},
      // 'external': {
      //   // 'wallets': ['paytm']
      // }
    };

    try {
      _razorpay.open(options);
      PayModel().initState();
    } catch (e) {
      print(e.toString());
    }
  }
}
