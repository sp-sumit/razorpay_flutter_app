import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PayModel {
  final _razorpay = Razorpay();

  initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(msg: "SUCCESS: " + (response.paymentId as String));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " +
          response.code.toString() +
          " - " +
          (response.message as String),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + (response.walletName as String),
    );
  }
}
