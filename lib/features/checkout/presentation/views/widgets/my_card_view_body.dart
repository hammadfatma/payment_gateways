import 'package:flutter/material.dart';
import 'package:payment_geteways/core/widgets/custom_button.dart';
import 'package:payment_geteways/features/checkout/presentation/views/widgets/card_info_item.dart';
import 'package:payment_geteways/features/checkout/presentation/views/widgets/payment_method_list_view.dart';
import 'package:payment_geteways/features/checkout/presentation/views/widgets/total_price_widget.dart';

class MyCardViewBody extends StatelessWidget {
  const MyCardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const SizedBox(
            height: 18,
          ),
          Expanded(child: Image.asset('assets/images/basket_image.png')),
          const SizedBox(
            height: 25,
          ),
          const OrderInfoItem(
            title: 'Order Subtotal',
            value: r'42.97$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Discount',
            value: r'0$',
          ),
          const SizedBox(
            height: 3,
          ),
          const OrderInfoItem(
            title: 'Shipping',
            value: r'8$',
          ),
          const Divider(
            thickness: 2,
            height: 34,
            color: Color(0xffC7C7C7),
          ),
          const TotalPrice(
            title: 'Total',
            value: r'$50.97',
          ),
          const SizedBox(
            height: 16,
          ),
          CustomButton(
            onTap: () {
              /*Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const PaymentDetailsView()));*/
              showModalBottomSheet(
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  builder: (context) {
                    return const PaymentMethodsBottomSheet();
                  });
            },
            text: 'Complete Payment',
          ),
          const SizedBox(
            height: 12,
          ),
        ],
      ),
    );
  }
}

class PaymentMethodsBottomSheet extends StatelessWidget {
  const PaymentMethodsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 16,
          ),
          PaymentMethodsListView(),
          SizedBox(
            height: 32,
          ),
          CustomButton(text: 'Continue'),
        ],
      ),
    );
  }
}
