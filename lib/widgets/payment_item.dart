import 'package:flutter/material.dart';
import 'package:sims_ppob/models/payment_model.dart';

class PaymentItem extends StatelessWidget {
  final PaymentModel paymentModel;
  final VoidCallback onTap;
  const PaymentItem({
    super.key,

    required this.paymentModel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(paymentModel.imageUrl, width: 50, height: 50),
          Text(paymentModel.label, style: TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
