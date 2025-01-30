import 'package:dartz/dartz.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/Features/checkout/data/models/payment_initent_input_model.dart';
import 'package:payment/Features/checkout/data/repos/checkout_repo.dart';
import 'package:payment/core/errors/failure.dart';
import 'package:payment/core/services/stripe_services.dart';

class CheckoutRepoImpel extends CheckoutRepo {
  final StripeServices stripeServices = StripeServices();
  @override
  Future<Either<Failure, void>> makePayment(
      {required PaymentInitentInputModel paymentInitentInputModel}) async {
    try {
      await stripeServices.makePayment(
          paymentInitentInputModel: paymentInitentInputModel);
      return right(null);
    } on StripeException catch (e) {
      return left(ServerError(errMessage: e.toString()));
    } catch (e) {
      return left(ServerError(errMessage: e.toString()));
    }
  }
}
