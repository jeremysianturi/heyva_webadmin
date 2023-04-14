import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../models/privacypolicy_model.dart';

class PrivacyPolicyProvider {
  final Dio _client;

  PrivacyPolicyProvider(this._client);

  Future<PrivacyPolicyModel?> Login({required username, required password}) async {
    PrivacyPolicyModel? res;
    try {
      Response response = await _client.post(
        '/api/v1/users/login',
        data: {"username": username, "password": password},
      );
      debugPrint('response data: ${response.data}');
      res = PrivacyPolicyModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res = PrivacyPolicyModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }
}