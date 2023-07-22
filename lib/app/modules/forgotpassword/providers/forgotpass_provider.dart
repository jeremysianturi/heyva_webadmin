import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:heyva_web_admin/app/modules/forgotpassword/model/forgotpass_model.dart';

class ForgotPasswordProvider {
  final Dio _client;

  ForgotPasswordProvider(this._client);

  Future<ForgotPasswordModel?> ForgotPassword({required username, required password}) async {
    ForgotPasswordModel? res;
    try {
      Response response = await _client.post(
        '/api/v1/users/login',
        data: {"username": username, "password": password},
      );
      res = ForgotPasswordModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res = ForgotPasswordModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }

  Future<ForgotPasswordModel?> refreshToken(
      {required userId, required refreshToken}) async {
    ForgotPasswordModel? res;
    try {
      Response response = await _client.post(
        '/api/v1/users/refresh-token',
        data: {"id": userId, "refresh_token": refreshToken},
      );
      debugPrint('response data: ${response.data}');
      res = ForgotPasswordModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res = ForgotPasswordModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }
}