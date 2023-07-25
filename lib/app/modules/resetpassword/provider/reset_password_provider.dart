import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../model/reset_password_model.dart';

class ResetPasswordProvider {
  final Dio _client;

  ResetPasswordProvider(this._client);

  Future<ResetPasswordModel?> resetPass(
      {required newPass, required confPass,required userId, required token}) async {
    ResetPasswordModel? res;
    try {
      Response response = await _client.put(
        '/api/v1/users/reset-password/$userId/$token',
        data: {"new_password": newPass, "confirm_new_password": confPass},
      );
      debugPrint('response data: ${response.data}');
      res = ResetPasswordModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      debugPrint("message error $message");
      res = ResetPasswordModel(
          success: "", data: null, message: message, error: error);
    }
    return res;
  }
}
