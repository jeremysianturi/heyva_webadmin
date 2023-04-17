import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/privacypolicy_model.dart';

class PrivacyPolicyProvider {
  final Dio _client;

  PrivacyPolicyProvider(this._client);

  Future<PrivacyPolicyModel?> getPrivacyPolicy() async {
    PrivacyPolicyModel? res;
    try {
      Response response = await _client.get(
        '/api/v1/terms-privacy/get-by-type?type=PRIVACY_AND_POLICY',
      );
      debugPrint('response data: ${response.data}');
      res = PrivacyPolicyModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res =
          PrivacyPolicyModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }
}