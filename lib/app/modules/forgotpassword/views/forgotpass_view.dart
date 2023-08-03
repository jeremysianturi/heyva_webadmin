import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heyva_web_admin/app/modules/forgotpassword/controllers/forgotpass_controller.dart';
import 'package:loading_overlay/loading_overlay.dart';

import '../../../../constant/colors.dart';
import '../../../../constant/strings.dart';
import '../../../controllers/auth_controller.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/reusable_orange_button_with_trailing_icon.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({Key? key}) : super(key: key);
  final forgotPassController = Get.put(ForgotPasswordController());
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
                      // child: TextButton(
                      //   onPressed: () {
                      //     // Get.to(TermsOfServiceView());
                      //     Get.toNamed(Routes.TERMS_OF_SERVICE);
                      //   },
                      //   child: const Text("Go to Terms of Service"),
                      // ),
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
                              Strings.forgot_password,
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
                                    controller: forgotPassController.emailC,
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
                                      controller: forgotPassController.passC,
                                      obscureText:
                                      forgotPassController.isObscure.value,
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
                                          errorText: controller.isPasserror.isTrue
                                              ? "error"
                                              : null,
                                          errorStyle:
                                          const TextStyle(fontSize: 0.01),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              forgotPassController.isObscure.value =
                                              !forgotPassController
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
                                                    forgotPassController
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
                          text: Strings.change_password,
                          onTap: () {
                            Get.offAllNamed(Routes.LOGIN);
                            FocusScope.of(context).requestFocus(FocusNode());
                            if (forgotPassController.validateData) {
                              forgotPassController.postLogin();
                            }
                          },
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container()
                  ),
                ],
              ),
            ),
          )),
    );
  }
}