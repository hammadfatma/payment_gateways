import 'package:dartz/dartz.dart';
import 'package:payment_geteways/core/errors/failures.dart';
import 'package:payment_geteways/features/checkout/data/models/payment_intent_input_model.dart';

abstract class CheckoutRepo {
  Future<Either<Failures, void>> makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel});
}
