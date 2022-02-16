import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter_app/Views/home.dart';
import 'package:razorpay_flutter_app/Views/splash.dart';

final routechanger = StateNotifierProvider<RouteManger, Widget>((ref) {
  return RouteManger();
});

class RouteManger extends StateNotifier<Widget> {
  RouteManger() : super(Splash()) {
    Future.delayed(const Duration(seconds: 2)).then((value) => state = Home());
  }
}
