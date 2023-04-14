import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyva_web_admin/constant/variabels.dart';
import '../constant/keys.dart';
import 'logging.dart';

class DioClient {
  Dio init() {
    var box = GetStorage();
    debugPrint("token ${box.read(Keys.loginAccessToken)}");
    var token = box.read(Keys.loginAccessToken).toString();
    Dio _dio = Dio();
    _dio.interceptors.add(Logging());
    _dio.options = BaseOptions(
      baseUrl: "http://api-service.heyva.health/",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': token != "null" ? "Bearer $token" : basicAuthToken,
        'Authorization': basicAuthToken,
      },
      connectTimeout: 20.seconds,
      receiveTimeout: 10.seconds,
    );
    _dio.options.baseUrl = "http://api-service.heyva.health/";
    return _dio;
  }
}
