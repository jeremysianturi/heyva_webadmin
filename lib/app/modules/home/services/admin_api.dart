import 'package:dio/dio.dart';
import 'package:get/get.dart' as milliseconds;
import '../../../../constant/variables.dart';
import '../../../../services/dio_services.dart';


class AdminClient {
  final Dio _dio = Dio();
  late String accessToken;

  Dio init() {
    // Dio _dio = Dio();
    // _dio.interceptors.add(toBeDefined());
    accessToken = authToken;
    // For refreshToken test
    // accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkZW50aWZpZXIiOiJmNTA0M2Q1OS1hY2QxLTQ5MmUtODAzOC0wZmUwMDMwNmYwNTEiLCJleHAiOjE2ODQ1NzIzMzEsImlhdCI6MTY4NDU2ODczMS40NDU0OTQsInNjb3BlIjoiQUNDRVNTIiwidXNlcm5hbWUiOiJhZG1pbl9oZXl2YSIsImVtYWlsIjpudWxsLCJwaG9uZV9udW1iZXIiOm51bGwsInByb2ZpbGVfY29kZSI6IjIwMjMwMzE2MDAwMDAwMTYiLCJyb2xlcyI6WyI3NjM5ZWI4OS01Yzc2LTQwMjgtYTliZi03MGQwMDA4ZjcxNGUiLCJlZjM2MmRhZS02NTc5LTQzOGYtYTA5OS0xNDhkZWRmYzI2YjAiXX0.XY3AAO6kvuyI3V_LRi1QV_nKhNcYWe2prPAFlIZWZVk";
    _dio.options = BaseOptions(
      baseUrl: heyApiBaseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      connectTimeout: 5000.milliseconds,
      receiveTimeout: 3000.milliseconds,
    );
    return _dio;
  }
  refreshOption() {
    accessToken = authToken;
    _dio.options = BaseOptions(
      baseUrl: heyApiBaseUrl,
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
      connectTimeout: 5000.milliseconds,
      receiveTimeout: 3000.milliseconds,
    );
  }
}
