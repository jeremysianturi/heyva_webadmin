import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/strings.dart';
import '../../../widgets/reusable_orange_button_with_trailing_icon.dart';
import '../controllers/resetpassword_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  ResetPasswordView({super.key});

  final resetPasswordController = Get.put(ResetPasswordController());
  // final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "requset reset token  ${Get.parameters['request_reset_password_token']}");

    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_web.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(),
            Column(
              children: [
                SvgPicture.asset("assets/images/heyva_logo.svg"),
                const Text(
                  Strings.tagline_splash,
                  style: TextStyle(
                      color: ColorApp.black_font_underline,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ],
            ),
            const Text(
              Strings.change_your_password,
              style: TextStyle(
                  color: ColorApp.black_article_title,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42.5),
              child: Column(
                children: [
                  Obx(
                    () => TextField(
                      controller: resetPasswordController.passC,
                      obscureText:
                          resetPasswordController.isObsecurePass.value,
                      decoration: InputDecoration(
                          hintText: Strings.your_new_password,
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
                          errorText:
                              resetPasswordController.isPassError.isTrue
                                  ? "error"
                                  : null,
                          errorStyle: const TextStyle(fontSize: 0.01),
                          suffixIcon: InkWell(
                            onTap: () {
                              resetPasswordController.isObsecurePass.value =
                                  !resetPasswordController
                                      .isObsecurePass.value;
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    resetPasswordController
                                            .isObsecurePass.isTrue
                                        ? "Show"
                                        : "Hide",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorApp.black_font_50),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Obx(
                    () => TextField(
                      controller: resetPasswordController.confPassC,
                      obscureText:
                          resetPasswordController.isObsecureConfPass.value,
                      decoration: InputDecoration(
                          hintText: Strings.confirm_your_password,
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
                          errorText:
                              resetPasswordController.isConfPasError.isTrue
                                  ? "error"
                                  : null,
                          errorStyle: const TextStyle(fontSize: 0.01),
                          suffixIcon: InkWell(
                            onTap: () {
                              resetPasswordController
                                      .isObsecureConfPass.value =
                                  !resetPasswordController
                                      .isObsecureConfPass.value;
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
                                  child: Text(
                                    resetPasswordController
                                            .isObsecureConfPass.isTrue
                                        ? "Show"
                                        : "Hide",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: ColorApp.black_font_50),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                  if (resetPasswordController.errorMessage.value.isNotEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 8),
                      width: Get.width,
                      child: Text(
                        resetPasswordController.errorMessage.value,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: ColorApp.red_error),
                        textAlign: TextAlign.center,
                      ),
                    )
                ],
              ),
            ),
            OrangeButtonWTrailingIcon(
              text: Strings.change_password,
              onTap: () {
                controller.resetPassword();
              },
            ),
          ],
        ),
      ),
    );
  }
}
