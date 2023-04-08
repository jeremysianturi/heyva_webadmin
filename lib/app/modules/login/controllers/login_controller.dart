import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../constant/keys.dart';
import '../../../../constant/strings.dart';
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

  var loginResponse =
      LoginModel(success: "", data: null, message: "", error: "").obs;

  postLogin() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      loginResponse.value =
      (await _provider.Login(username: emailC.text, password: passC.text))!;
      isLoading.value = false;
      debugPrint('response data: ${loginResponse.value.success}');

      if (loginResponse.value.success == "Success") {
        var box = GetStorage();
        box.write(
            Keys.loginAccessToken, loginResponse.value.data?.accessToken ?? "");
        box.write(Keys.loginRefreshToken,
            loginResponse.value.data?.refreshToken ?? "");
        800.milliseconds;
        Get.toNamed(Routes.RESET_PASSWORD);
      } else {
        if (loginResponse.value.message.toString().toLowerCase().contains("pass")) {
          isPasserror.value = true;
        } else {
          isEmailError.value = true;
          isPasserror.value = true;
        }
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