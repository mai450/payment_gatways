import 'package:dartz/dartz.dart';
import 'package:payment/Features/checkout/data/models/payment_initent_input_model.dart';
import 'package:payment/core/errors/failure.dart';

abstract class CheckoutRepo {
  Future<Either<Failure, void>> makePayment(
      {required PaymentInitentInputModel paymentInitentInputModel});
}
