import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment/Features/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment/Features/checkout/data/models/amount_model/details.dart';
import 'package:payment/Features/checkout/data/models/list_items_model/item.dart';
import 'package:payment/Features/checkout/data/models/list_items_model/list_items_model.dart';
import 'package:payment/Features/checkout/data/models/payment_initent_input_model.dart';
import 'package:payment/Features/checkout/presentation/manger/payment_cubit/payment_cubit.dart';
import 'package:payment/Features/checkout/presentation/views/thank_you_view.dart';
import 'package:payment/core/utils/api_keys.dart';
import 'package:payment/core/widgets/custom_button.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentCubitState>(
      listener: (context, state) {
        if (state is PaymentCubitSuccess) {
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            return const ThankYouView();
          }));
        }

        if (state is PaymentCubitFailure) {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return CustomButton(
            selectedButton: index,
            onTap2: (selectedButton) {
              if (selectedButton == 0) {
                PaymentInitentInputModel paymentInitentInputModel =
                    PaymentInitentInputModel(
                        amount: '100',
                        currency: 'USD',
                        customerId: 'cus_RepmDZmxGb73xy');
                BlocProvider.of<PaymentCubit>(context).makePayment(
                    paymentInitentInputModel: paymentInitentInputModel);
              } else {
                var transactionData = getTransactionData();
                executePaypalPayment(context, transactionData);
              }
            },
            isLoading: state is PaymentCubitLoading ? true : false,
            text: 'Continue');
      },
    );
  }

  void executePaypalPayment(BuildContext context,
      ({AmountModel amount, ListItemsModel listItem}) transactionData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.paypalClientId,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [
          {
            "amount": transactionData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transactionData.listItem.toJson()
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }

  ({AmountModel amount, ListItemsModel listItem}) getTransactionData() {
    var amount = AmountModel(
      currency: "USD",
      total: "100",
      details: Details(
        subtotal: "100",
        shipping: "0",
        shippingDiscount: 0,
      ),
    );
    List<Item> orders = [
      Item(name: "Apple", currency: "USD", price: "10", quantity: 4),
      Item(name: "banana", currency: "USD", price: "12", quantity: 5),
    ];
    var listItem = ListItemsModel(items: orders);
    return (amount: amount, listItem: listItem);
  }
}
