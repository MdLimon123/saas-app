// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:no_name_ecommerce/services/cart_services/cart_service.dart';
import 'package:no_name_ecommerce/view/payments/payfast_payment.dart';
import 'package:provider/provider.dart';

class PayfastService {
  payByPayfast(BuildContext context) {
    String amount = Provider.of<CartService>(context, listen: false)
        .totalPrice
        .toStringAsFixed(2);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => PayfastPayment(
          amount: amount,
          name: 'name',
          phone: 'phone',
          email: 'email',
        ),
      ),
    );
  }
}
