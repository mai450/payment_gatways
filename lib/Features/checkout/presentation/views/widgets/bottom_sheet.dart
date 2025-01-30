import 'package:flutter/material.dart';
import 'package:payment/Features/checkout/presentation/views/widgets/custom_button_bloc_consumer.dart';
import 'package:payment/Features/checkout/presentation/views/widgets/payment_methods_list_view.dart';
import 'package:payment/core/widgets/custom_button.dart';

class PaymentMethodsBottomSheet extends StatefulWidget {
  const PaymentMethodsBottomSheet({
    super.key,
  });

  @override
  State<PaymentMethodsBottomSheet> createState() =>
      _PaymentMethodsBottomSheetState();
}

class _PaymentMethodsBottomSheetState extends State<PaymentMethodsBottomSheet> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(
            index: (p0) {
              index = p0;
              setState(() {});
            },
          ),
          SizedBox(
            height: 32,
          ),
          CustomButtonBlocConsumer(index: index),
        ],
      ),
    );
  }
}
