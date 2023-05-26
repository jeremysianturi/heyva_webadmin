import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyva_web_admin/app/modules/home/views/admin_layout.dart';
import '../../../../constant/keys.dart';
import '../../../../constant/strings.dart';
import '../../../../constant/variables.dart';
import '../../../../services/dio_services.dart';
import '../../../routes/app_pages.dart';
import '../../home/controllers/admin_routes.dart';
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
  var isPassError = false.obs;
  var box = GetStorage();

  @override
  void onInit() {
    _client = DioClient();
    _provider = LoginProvider(_client.init());
    super.onInit();
  }

  bool get validateData {
    isEmailError.value = false;
    isPassError.value = false;
    errorMessage.value = "";
    if (emailC.text.isEmpty) {
      isEmailError.value = true;
      errorMessage.value = Strings.emptyForm;
      return false;
    }
    if (passC.text.isEmpty) {
      isPassError.value = true;
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

  var loginResponse =
      LoginModel(success: "", data: null, message: "", error: "").obs;

  postLogin() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      loginResponse.value =
      (await _provider.Login(username: emailC.text, password: passC.text))!;
      isLoading.value = false;

      if (loginResponse.value.success == "Success") {
        var box = GetStorage();
        box.write(
            Keys.loginAccessToken, loginResponse.value.data?.accessToken ?? "");
        box.write(Keys.loginRefreshToken,
            loginResponse.value.data?.refreshToken ?? "");
        box.write(Keys.loginID, loginResponse.value.data?.id ?? "");
        authToken = box.read(Keys.loginAccessToken).toString();
        refreshToken = box.read(Keys.loginRefreshToken).toString();
        Future.delayed(800.milliseconds);
        // Get.toNamed(Routes.PRIVACY_POLICY);
        Get.off(const AdminLayout());
      } else {
        if (loginResponse.value.message
            .toString()
            .toLowerCase()
            .contains("pass")) {
          isPassError.value = true;
        } else {
          isEmailError.value = true;
          isPassError.value = true;
        }
        errorMessage.value = loginResponse.value.message ?? "Error Message";
      }
    } catch (e) {
      isLoading.value = false;

      debugPrint("error  $e");
    }
  }

  var response =
      LoginModel(success: "", data: null, message: "", error: "").obs;

  tokenRefresh() async {
    errorMessage.value = "";
    isLoading.value = true;
    var userId = box.read(Keys.loginID);
    var refresh = box.read(Keys.loginRefreshToken);
    try {
      response.value =
      (await _provider.refreshToken(refreshToken: refresh, userId: userId))!;
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
        errorMessage.value = loginResponse.value.message ?? "Error Message";
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