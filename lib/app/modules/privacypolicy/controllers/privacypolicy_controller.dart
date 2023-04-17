import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../constant/keys.dart';
import '../../../../services/dio_services.dart';
import '../models/privacypolicy_model.dart';
import '../providers/privacypolicy_provider.dart';

class PrivacyPolicyController extends GetxController {
  var isLoading = false.obs;
  late DioClient _client;
  late PrivacyPolicyProvider _privacyPolicyProvider;
  var errorMessage = ''.obs;
  var box = GetStorage();

  String get privacyPolicyText {
    var read = box.read(Keys.privacyPolicyText) ?? "";
    if (read.toString().isNotEmpty) {
      return box.read(Keys.privacyPolicyText) ?? "";
    } else {
      return privacyPolicyResponse.value.data?.textContent ?? "";
    }
  }

  @override
  void onInit() {
    _client = DioClient();
    _privacyPolicyProvider = PrivacyPolicyProvider(_client.init());
    getPrivacyPolicy();
    super.onInit();
  }

  var privacyPolicyResponse =
      PrivacyPolicyModel(success: "", data: null, message: "", error: "").obs;

  getPrivacyPolicy() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      privacyPolicyResponse.value = (await _privacyPolicyProvider.getPrivacyPolicy())!;
      isLoading.value = false;

      if (privacyPolicyResponse.value.success == "Success") {
        var data = privacyPolicyResponse.value.data;
        debugPrint("check value privacy policy: ${privacyPolicyResponse.value.data}");
        box.write(Keys.privacyPolicyText, data?.textContent);
      } else {
        errorMessage.value = privacyPolicyResponse.value.message ?? "Error Message";
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("error  $e");
    }
  }
}