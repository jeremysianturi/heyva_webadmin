import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/app/widgets/reusable_bottomSheet_message.dart';

import '../../../../constant/strings.dart';
import '../../../../services/dio_services.dart';
import '../../../routes/app_pages.dart';
import '../model/reset_password_model.dart';
import '../provider/reset_password_provider.dart';

class ResetPasswordController extends GetxController {
  TextEditingController passC = TextEditingController();
  TextEditingController confPassC = TextEditingController();
  RxBool isObsecurePass = true.obs;
  RxBool isObsecureConfPass = true.obs;

  var isLoading = false.obs;
  late DioClient _client;
  late ResetPasswordProvider _provider;
  var errorMessage = ''.obs;
  var isPassError = false.obs;
  var isConfPasError = false.obs;

  @override
  void onInit() {
    _client = DioClient();
    _provider = ResetPasswordProvider(_client.init());
    super.onInit();
  }

  bool get validateData {
    isPassError.value = false;
    isConfPasError.value = false;
    errorMessage.value = "";
    if (passC.text.isEmpty) {
      isPassError.value = true;
      errorMessage.value = Strings.emptyForm;
      return false;
    }
    if (confPassC.text.isEmpty) {
      isConfPasError.value = true;
      errorMessage.value = Strings.emptyForm;
      return false;
    }
    if (passC.text.length < 8) {
      isPassError.value = true;
      errorMessage.value = Strings.atLeast8Char;
      return false;
    }
    if (confPassC.text.length < 8) {
      isConfPasError.value = true;
      errorMessage.value = Strings.atLeast8Char;
      return false;
    }
    return true;
  }

  var resetPassResponse =
      ResetPasswordModel(success: "", data: null, message: "", error: "").obs;

  resetPassword() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      resetPassResponse.value = (await _provider.resetPass(
        confPass: confPassC.text,
        newPass: passC.text,
        token:
            "${Get.parameters['userid']}/${Get.parameters['request_reset_password_token']}",
      ))!;
      isLoading.value = false;

      if (resetPassResponse.value.success == "Success") {
        bottomSheetMessage(
            color: "green", desc: "reset password successfully ");
        Future.delayed(2.seconds, () {
          Get.offNamed(Routes.LOGIN);
        });
      } else {
        errorMessage.value = resetPassResponse.value.message ?? "Error Message";
        bottomSheetMessage(color: "red", desc: errorMessage.value);

      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("error  $e");
    }
  }

  @override
  void onClose() {
    confPassC.dispose();
    passC.dispose();
    super.onClose();
  }
}
