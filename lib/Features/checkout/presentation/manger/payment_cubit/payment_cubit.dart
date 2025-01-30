import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:payment/Features/checkout/data/models/payment_initent_input_model.dart';
import 'package:payment/Features/checkout/data/repos/checkout_repo.dart';

part 'payment_cubit_state.dart';

class PaymentCubit extends Cubit<PaymentCubitState> {
  PaymentCubit(this.checkoutRepo) : super(PaymentCubitInitial());

  final CheckoutRepo checkoutRepo;

  Future makePayment(
      {required PaymentInitentInputModel paymentInitentInputModel}) async {
    emit(PaymentCubitLoading());

    var data = await checkoutRepo.makePayment(
        paymentInitentInputModel: paymentInitentInputModel);
    data.fold(
      (l) => emit(PaymentCubitFailure(errMessage: l.errMessage)),
      (r) => emit(PaymentCubitSuccess()),
    );
  }
}
