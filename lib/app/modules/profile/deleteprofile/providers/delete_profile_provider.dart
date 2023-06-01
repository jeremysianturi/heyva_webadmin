import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../model/delete_account_model.dart';

class DeleteProfileProvider {
  final Dio _client;

  DeleteProfileProvider(this._client);


  Future<DeleteAccountModel?> deleteAccount() async {
    DeleteAccountModel? res;
    try {
      Response response =
      await _client.delete('/api/v1/users/delete');
      debugPrint('response data: ${response.data}');
      res = DeleteAccountModel.fromJson(response.data);
    } on DioError catch (e) {
      var message = e.response?.data['message'];
      var error = e.response?.data['error'];
      res = DeleteAccountModel(
          success: "", data: null, message: message, error: error);
    }
    return res;
  }
}