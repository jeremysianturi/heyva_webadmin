import 'package:flutter/material.dart';
import 'package:get/get.dart';
<<<<<<< HEAD
import 'package:heyva_web_admin/app/modules/resetpassword/views/resetpassword_view.dart';
import 'package:heyva_web_admin/app/modules/termsofservice/views/termsofservice_view.dart';
=======
import 'package:heyva_web_admin/app/routes/app_pages.dart';
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/strings.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/reusable_orange_button_with_trailing_icon.dart';
<<<<<<< HEAD
import '../../forgotpassword/views/forgotpass_view.dart';
import '../../home/views/admin_layout.dart';
import '../../privacypolicy/views/privacypolicy_view.dart';
=======
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  // final loginController = Get.put(LoginController());
  final loginController = Get.find<LoginController>();
  final authC = Get.find<AuthController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingOverlay(
          isLoading: controller.isLoading.value,
          color: ColorApp.btn_orange,
          opacity: 0.3,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              height: double.maxFinite,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/bg_heyva.png"),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
<<<<<<< HEAD
=======
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              // Get.to(TermsOfServiceView());
                              Get.toNamed(Routes.TERMS_OF_SERVICE);
                            },
                            child: const Text("Go to Terms of Service"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Get.to(PrivacyPolicyView());
                              Get.toNamed(Routes.PRIVACY_POLICY);
                            },
                            child: const Text("Go to Privacy Policy"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Get.to(ForgotPasswordView());
                              Get.toNamed(Routes.FORGOT_PASSWORD);
                            },
                            child: const Text("Go to Forgot Password"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Get.to(ForgotPasswordView());
                              Get.toNamed(Routes.RESET_PASSWORD);
                            },
                            child: const Text("Go to Reset Password"),
                          ),
                        ],
                      ),
>>>>>>> 64b537176efe83695f2badc6fc12448d0c01149d
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              Strings.login,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 1, child: Container()),
                            Expanded(flex: 1, child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  TextFormField(
                                    controller: loginController.emailC,
                                    decoration: InputDecoration(
                                      hintText: Strings.email_adress,
                                      contentPadding: const EdgeInsets.symmetric(
                                          vertical: 17, horizontal: 20),
                                      filled: true,
                                      fillColor: ColorApp.text_input_bg,
                                      hintStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: ColorApp.grey_font),
                                      labelStyle: const TextStyle(
                                          fontSize: 16,
                                          color: ColorApp.black_font_underline,
                                          fontWeight: FontWeight.w400),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                        borderSide: const BorderSide(
                                          color: ColorApp.red_error,
                                          width: 2.0,
                                        ),
                                      ),
                                      errorText: controller.isEmailError.isTrue
                                          ? "error"
                                          : null,
                                      errorStyle: const TextStyle(fontSize: 0.01),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Obx(
                                        () => TextField(
                                      controller: loginController.passC,
                                      obscureText:
                                      loginController.isObscure.value,
                                      decoration: InputDecoration(
                                          hintText: Strings.password,
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 17, horizontal: 20),
                                          filled: true,
                                          fillColor: ColorApp.text_input_bg,
                                          hintStyle: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color: ColorApp.grey_font),
                                          labelStyle: const TextStyle(
                                              fontSize: 16,
                                              color:
                                              ColorApp.black_font_underline,
                                              fontWeight: FontWeight.w400),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(14),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(14),
                                            borderSide: const BorderSide(
                                              color: ColorApp.red_error,
                                              width: 2.0,
                                            ),
                                          ),
                                          errorText: controller.isPassError.isTrue
                                              ? "error"
                                              : null,
                                          errorStyle:
                                          const TextStyle(fontSize: 0.01),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              loginController.isObscure.value =
                                              !loginController
                                                  .isObscure.value;
                                            },
                                            child: Column(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      right: 20.0),
                                                  child: Text(
                                                    loginController
                                                        .isObscure.isTrue
                                                        ? "Show"
                                                        : "Hide",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                        FontWeight.w600,
                                                        color: ColorApp
                                                            .black_font_underline),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ),
                                  ),
                                  if (controller.errorMessage.value.isNotEmpty)
                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      width: Get.width,
                                      child: Text(
                                        controller.errorMessage.value,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: ColorApp.red_error),
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                ],
                              ),
                            ),),
                            Expanded(flex: 1, child: Container()),
                          ],
                        ),
                        OrangeButtonWTrailingIcon(
                          text: Strings.login,
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (loginController.validateData) {
                              bool isLogged = await loginController.postLogin();
                              if(isLogged) {
                                loginController.emailC.clear();
                                loginController.passC.clear();
                                Get.off(AdminLayout());
                              }
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(TermsOfServiceView());
                          },
                          child: const Text("Go to Terms of Service"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(PrivacyPolicyView());
                          },
                          child: const Text("Go to Privacy Policy"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(ForgotPasswordView());
                          },
                          child: const Text("Go to Forgot Password"),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(ResetPasswordView());
                          },
                          child: const Text("Go to Reset Password"),
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
