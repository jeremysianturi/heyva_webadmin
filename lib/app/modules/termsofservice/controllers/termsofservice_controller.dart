import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../constant/keys.dart';
import '../../../../services/dio_services.dart';
import '../models/termsofservice_model.dart';
import '../providers/termsofservice_provider.dart';

class TermsOfServiceController extends GetxController {
  var isLoading = false.obs;
  late DioClient _client;
  late TermsOfServiceProvider _termsOfServiceProvider;
  var errorMessage = ''.obs;
  var box = GetStorage();

  String get termsOfServiceText {
    var read = box.read(Keys.termsOfServiceText) ?? "";
    if (read.toString().isNotEmpty) {
      return box.read(Keys.termsOfServiceText) ?? "";
    } else {
      return termsOfServiceResponse.value.data?.textContent ?? "";
    }
  }

  @override
  void onInit() {
    _client = DioClient();
    _termsOfServiceProvider = TermsOfServiceProvider(_client.init());
    getTermsOfService();
    super.onInit();
  }

  var termsOfServiceResponse =
      TermsOfServiceModel(success: "", data: null, message: "", error: "").obs;

  getTermsOfService() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      termsOfServiceResponse.value = (await _termsOfServiceProvider.getTermsOfService())!;
      isLoading.value = false;

      if (termsOfServiceResponse.value.success == "Success") {
        var data = termsOfServiceResponse.value.data;
        // debugPrint("check value terms of service: ${termsOfServiceResponse.value.data}");
        box.write(Keys.termsOfServiceText, data?.textContent);
      } else {
        errorMessage.value = termsOfServiceResponse.value.message ?? "Error Message";
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("error  $e");
    }
  }
}