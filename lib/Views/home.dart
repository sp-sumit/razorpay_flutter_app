import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:razorpay_flutter_app/DataProvider/pay_handler.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Consumer(builder: (context, state, child) {
              return ElevatedButton(
                onPressed: () async {
                  state.watch(payHandler.notifier).openCheckout();
                },
                child: const Text('Pay'),
              );
            }),
          ],
        ),
      ),
    );
  }
}
