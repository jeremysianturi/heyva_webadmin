import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../constant/keys.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/variabels.dart';
import '../../../../services/dio_services.dart';
import '../../../routes/app_pages.dart';
import '../model/login_model.dart';
import '../providers/login_provider.dart';

class LoginController extends GetxController {
  TextEditingController emailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  RxBool isObscure = true.obs;

  var isLoading = false.obs;
  late DioClient _client;
  late LoginProvider _provider;
  var errorMessage = ''.obs;
  var isEmailError = false.obs;
  var isPasserror = false.obs;
  var box = GetStorage();

  @override
  void onInit() {
    _client = DioClient();
    _provider = LoginProvider(_client.init());
    super.onInit();
  }

  bool get validateData {
    isEmailError.value = false;
    isPasserror.value = false;
    errorMessage.value = "";
    if (emailC.text.isEmpty) {
      isEmailError.value = true;
      errorMessage.value = Strings.emptyForm;
      return false;
    }
    if (passC.text.isEmpty) {
      isPasserror.value = true;
      errorMessage.value = Strings.emptyForm;
      return false;
    }
    // if (!GetUtils.isEmail(emailC.text)) {
    //   isEmailError.value = true;
    //   errorMessage.value = Strings.invalidEmail;
    //   return false;
    // }
    return true;
  }

  var loginResonse =
      LoginModel(success: "", data: null, message: "", error: "").obs;

  postLogin() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      loginResonse.value =
      (await _provider.Login(username: emailC.text, password: passC.text))!;
      isLoading.value = false;

      if (loginResonse.value.success == "Success") {
        var box = GetStorage();
        box.write(
            Keys.loginAccessToken, loginResonse.value.data?.accessToken ?? "");
        box.write(Keys.loginRefreshToken,
            loginResonse.value.data?.refreshToken ?? "");
        box.write(Keys.loginID, loginResonse.value.data?.id ?? "");
        Future.delayed(800.milliseconds);
        Get.toNamed(Routes.PRIVACY_POLICY);
      } else {
        if (loginResonse.value.message
            .toString()
            .toLowerCase()
            .contains("pass")) {
          isPasserror.value = true;
        } else {
          isEmailError.value = true;
          isPasserror.value = true;
        }
        errorMessage.value = loginResonse.value.message ?? "Error Message";
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("error  $e");
    }
  }

  var response =
      LoginModel(success: "", data: null, message: "", error: "").obs;

  refresh() async {
    errorMessage.value = "";
    isLoading.value = true;
    var userId = box.read(Keys.loginID);
    var refres = box.read(Keys.loginRefreshToken);
    try {
      response.value =
      (await _provider.refreshToken(refreshToken: refres, userId: userId))!;
      isLoading.value = false;

      if (response.value.success == "Success") {
        box.write(
            Keys.loginAccessToken, response.value.data?.accessToken ?? "");
        box.write(
            Keys.loginRefreshToken, response.value.data?.refreshToken ?? "");
        box.write(Keys.loginID, response.value.data?.id ?? "");
        authToken = box.read(Keys.loginAccessToken).toString();
        refreshToken = box.read(Keys.loginRefreshToken).toString();
        Future.delayed(800.milliseconds);
        Get.toNamed(Routes.PRIVACY_POLICY);
      } else {
        errorMessage.value = loginResonse.value.message ?? "Error Message";
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("error  $e");
    }
  }

  @override
  void onClose() {
    emailC.dispose();
    passC.dispose();
    super.onClose();
  }
}