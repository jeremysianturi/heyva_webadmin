import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/constant/variabels.dart';
import 'logging.dart';

class DioClient {
  Dio init() {
    Dio dio = Dio();
    dio.interceptors.add(Logging());
    dio.options = BaseOptions(
      baseUrl: "http://54.251.132.179:8000",
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': authToken.isNotEmpty ? authToken : basicAuthToken,
      },
      connectTimeout: 20.seconds,
      receiveTimeout: 10.seconds,
    );
    dio.options.baseUrl = "http://54.251.132.179:8000";
    return dio;
  }
}
