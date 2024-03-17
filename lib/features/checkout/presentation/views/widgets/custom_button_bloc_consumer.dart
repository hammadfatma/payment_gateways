import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:payment_geteways/core/utils/api_keys.dart';
import 'package:payment_geteways/core/widgets/custom_button.dart';
import 'package:payment_geteways/features/checkout/data/models/amount_model/amount_model.dart';
import 'package:payment_geteways/features/checkout/data/models/amount_model/details.dart';
import 'package:payment_geteways/features/checkout/data/models/item_list_model/item.dart';
import 'package:payment_geteways/features/checkout/data/models/item_list_model/item_list_model.dart';
import 'package:payment_geteways/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_geteways/features/checkout/presentation/manager/cubit/payment_cubit.dart';
import 'package:payment_geteways/features/checkout/presentation/views/thank_you_view.dart';

class CustomButtonBlocConsumer extends StatelessWidget {
  const CustomButtonBlocConsumer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state is PaymentSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const ThankYouView(),
            ),
          );
        }
        if (state is PaymentFailure) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(content: Text(state.errMessage));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return CustomButton(
            onTap: () {
              var transctionsData = getTransctionsData();
              exceutePaypalPayment(context, transctionsData);

              /*PaymentIntentInputModel paymentIntentInputModel =
                  PaymentIntentInputModel(
                amount: '100',
                currency: 'USD',
                customerId: 'cus_Onu3Wcrzhehlez', ////////
              );
              BlocProvider.of<PaymentCubit>(context).makePayment(
                  paymentIntentInputModel: paymentIntentInputModel);*/
            },
            isLoading: state is PaymentLoading ? true : false,
            text: 'Continue');
      },
    );
  }

  void exceutePaypalPayment(BuildContext context,
      ({AmountModel amount, ItemListModel itemList}) transctionsData) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        clientId: ApiKeys.clientID,
        secretKey: ApiKeys.paypalSecretKey,
        transactions: [
          {
            "amount": transctionsData.amount.toJson(),
            "description": "The payment transaction description.",
            "item_list": transctionsData.itemList.toJson(),
          }
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          log("onSuccess: $params");
          Navigator.pop(context);
        },
        onError: (error) {
          log("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
          Navigator.pop(context);
        },
      ),
    ));
  }
}

({AmountModel amount, ItemListModel itemList}) getTransctionsData() {
  var amount = AmountModel(
      total: "100",
      currency: 'USD',
      details: Details(
        shipping: "0",
        shippingDiscount: 0,
        subtotal: '100',
      ));
  List<OrderItemModel> orders = [
    OrderItemModel(
      currency: 'USD',
      name: 'Apple',
      price: "4",
      quantity: 10,
    ),
    OrderItemModel(
      currency: 'USD',
      name: 'Pineapple',
      price: "5",
      quantity: 12,
    ),
  ];
  var itemList = ItemListModel(orders: orders);
  return (amount: amount, itemList: itemList);
}
