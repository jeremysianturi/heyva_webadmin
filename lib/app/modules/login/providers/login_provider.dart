import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:heyva_web_admin/app/modules/login/model/login_model.dart';

import '../../../../services/dio_services.dart';

class LoginProvider {
  final Dio _client;

  LoginProvider(this._client);

  Future<LoginModel?> Login({required username, required password}) async {
    LoginModel? res;
    try {
      Response response = await _client.post(
        // 'http://54.169.131.201:8000/api/v1/users/login',
        '$heyApiBaseUrl/api/v1/users/login',
        data: {"username": username, "password": password},
      );
      res = LoginModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res = LoginModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }

  Future<LoginModel?> refreshToken(
      {required userId, required refreshToken}) async {
    LoginModel? res;
    try {
      Response response = await _client.post(
        '/api/v1/users/refresh-token',
        data: {"id": userId, "refresh_token": refreshToken},
      );
      debugPrint('response data: ${response.data}');
      res = LoginModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res = LoginModel(success: "", data: null, message: message, error: error);
    }
    return res;
  }
}
