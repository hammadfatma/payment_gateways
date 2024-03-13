import 'package:dartz/dartz.dart';
import 'package:payment_geteways/core/errors/failures.dart';
import 'package:payment_geteways/core/utils/stripe_service.dart';
import 'package:payment_geteways/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_geteways/features/checkout/data/repos/checkout_repo.dart';

class CheckoutRepoImpl extends CheckoutRepo {
  final StripeService stripeService = StripeService();
  @override
  Future<Either<Failures, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    try {
      await stripeService.makePayment(
          paymentIntentInputModel: paymentIntentInputModel);
      return right(null);
    } catch (e) {
      return left(ServceFailure(errMessage: e.toString()));
    }
  }
}
