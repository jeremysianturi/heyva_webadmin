import 'package:dio/dio.dart';

import '../models/termsofservice_model.dart';

class TermsOfServiceProvider {
  final Dio _client;

  TermsOfServiceProvider(this._client);

  Future<TermsOfServiceModel?> getTermsOfService() async {
    TermsOfServiceModel? res;
    try {
      Response response = await _client.get(
        '/api/v1/terms-privacy/get-by-type?type=TERMS_OF_SERVICE',
      );
      // debugPrint('response data: ${response.data}');
      res = TermsOfServiceModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res =
          TermsOfServiceModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }
}