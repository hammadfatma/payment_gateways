import 'package:flutter/material.dart';
import 'package:payment_geteways/core/widgets/custom_app_bar.dart';
import 'package:payment_geteways/features/checkout/presentation/views/widgets/my_card_view_body.dart';

class MyCardView extends StatelessWidget {
  const MyCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'My Cart'),
      body: const MyCardViewBody(),
    );
  }
}
