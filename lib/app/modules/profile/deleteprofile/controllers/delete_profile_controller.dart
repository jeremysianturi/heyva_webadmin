import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../constant/keys.dart';
import '../../../../../constant/variabels.dart';
import '../../../../../services/dio_services.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/reusable_bottomSheet_message.dart';
import '../model/delete_account_model.dart';
import '../providers/delete_profile_provider.dart';

class DeleteProfileController extends GetxController {

  var isLoading = false.obs;
  late DioClient _client;
  late DeleteProfileProvider _deleteProfileProvider;
  var errorMessage = "".obs;

  @override
  void onInit() {
    _client = DioClient();
    _deleteProfileProvider = DeleteProfileProvider(_client.init());

    super.onInit();
  }

  var deleteResponse =
      DeleteAccountModel(success: "", data: null, message: "", error: "").obs;

  deleteAccount() async {
    errorMessage.value = "";
    isLoading.value = true;
    try {
      deleteResponse.value = (await _deleteProfileProvider.deleteAccount())!;
      if (deleteResponse.value.success == "Success") {
        bottomSheetMessage(
            color: "heyva", desc: "Your account has been successfully deleted");
        Future.delayed(2.seconds, () {
          var box = GetStorage();
          box.remove(Keys.loginAccessToken);
          box.remove(Keys.loginRefreshToken);
          box.remove(Keys.loginID);
          box.remove(Keys.profileName);
          box.remove(Keys.profileImgUrl);
          box.erase();
          authToken = "";
          refreshToken = "";
          Future.delayed(800.seconds);
          Get.offNamed(Routes.SIGNUP);
        });
      } else {
        // bottomSheetMessage(
        //     color: "heyva",
        //     desc: "Oops! There is an error saving your profile.");
      }
    } catch (e) {
      isLoading.value = false;
      debugPrint("error  $e");
    }
  }
}