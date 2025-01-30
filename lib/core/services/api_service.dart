import 'package:dio/dio.dart';

class ApiService {
  ApiService({required this.dio});
  final Dio dio;
  // final _baseUrl = 'https://api.stripe.com/v1/';

  Future<Response> post(
      {required String endPoint,
      Map<String, dynamic>? headers,
      String? contentType,
      String? token,
      required body}) async {
    var response = await dio.post(endPoint,
        options: Options(
            headers: headers ?? {'Authorization': "Bearer $token"},
            contentType: contentType),
        data: body);
    return response;
  }
}
