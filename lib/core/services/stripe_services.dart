import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment/Features/checkout/data/models/ephemeral_keys_model/ephemeral_keys_model.dart';
import 'package:payment/Features/checkout/data/models/init_payment_sheet_input_model.dart';
import 'package:payment/Features/checkout/data/models/payment_initent_input_model.dart';
import 'package:payment/Features/checkout/data/models/payment_intent_model/payment_intent_model.dart';
import 'package:payment/core/services/api_service.dart';
import 'package:payment/core/utils/api_keys.dart';

class StripeServices {
  final ApiService apiService = ApiService(dio: Dio());

  Future<PaymentIntentModel> createPaymentInitent(
      {required PaymentInitentInputModel paymentInitentInputModel}) async {
    var response = await apiService.post(
        endPoint: 'https://api.stripe.com/v1/payment_intents',
        contentType: Headers.formUrlEncodedContentType,
        token: ApiKeys.secretKey,
        body: paymentInitentInputModel.toJson());

    var paymentIntentModel = PaymentIntentModel.fromJson(response.data);
    return paymentIntentModel;
  }

  Future initPaymentSheet(
      {required InitiPaymentSheetInputModel
          initiPaymentSheetInputModel}) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        // Main params
        merchantDisplayName: 'mai',
        paymentIntentClientSecret: initiPaymentSheetInputModel.clientSecret,
        customerEphemeralKeySecret:
            initiPaymentSheetInputModel.ephemeralKeySecret,
        customerId: initiPaymentSheetInputModel.customerId,
      ),
    );
  }

  Future displayPaymentSheet() async {
    await Stripe.instance.presentPaymentSheet();
  }

  Future makePayment(
      {required PaymentInitentInputModel paymentInitentInputModel}) async {
    var paymentInitentModel = await createPaymentInitent(
        paymentInitentInputModel: paymentInitentInputModel);
    var ephemeralKeyModel = await createEphemeralKeys(
        customerId: paymentInitentInputModel.customerId);
    var initiPaymentSheetInputModel = InitiPaymentSheetInputModel(
        clientSecret: paymentInitentModel.clientSecret!,
        customerId: paymentInitentInputModel.customerId,
        ephemeralKeySecret: ephemeralKeyModel.secret!);
    await initPaymentSheet(
        initiPaymentSheetInputModel: initiPaymentSheetInputModel);
    await displayPaymentSheet();
  }

  Future<EphemeralKeysModel> createEphemeralKeys(
      {required String customerId}) async {
    var response = await apiService.post(
        endPoint: 'https://api.stripe.com/v1/ephemeral_keys',
        contentType: Headers.formUrlEncodedContentType,
        body: {
          'customer': customerId,
        },
        headers: {
          'Authorization': "Bearer ${ApiKeys.secretKey}",
          'Stripe-Version': '2024-12-18.acacia',
        });

    var ephemeralKeyModel = EphemeralKeysModel.fromJson(response.data);
    return ephemeralKeyModel;
  }
}
