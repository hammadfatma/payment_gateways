import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment_geteways/features/checkout/data/models/payment_intent_input_model.dart';
import 'package:payment_geteways/features/checkout/data/repos/checkout_repo.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentInitial());
  final CheckoutRepo checkoutRepo;
  Future makePayment(
      {required PaymentIntentInputModel paymentIntentInputModel}) async {
    emit(PaymentLoading());
    var data = await checkoutRepo.makePayment(
        paymentIntentInputModel: paymentIntentInputModel);
    data.fold(
      (failure) => emit(PaymentFailure(failure.errMessage)),
      (success) => emit(
        PaymentSuccess(),
      ),
    );
  }
}
