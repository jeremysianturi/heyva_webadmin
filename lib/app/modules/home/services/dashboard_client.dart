
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:heyva_web_admin/app/modules/home/model/read_dashboard_data.dart';
import '../../login/controllers/login_controller.dart';
import 'admin_api.dart';
import 'package:get/get.dart' as milliseconds;

class ReadUserProvider {
  final Dio _readUserClient;
  ReadUserProvider(this._readUserClient);

  Future<GetUserList?> getUserList(int page) async {
    GetUserList? resp;
    int size = 10;

    try {
      Response response = await _readUserClient.get(
          "/api/v1/users/get-list",
      );
      resp = GetUserList.fromJson(response.data);

    } on DioError catch (err) {
      debugPrint('Get users list fail with result: ${err.response?.statusMessage}');
      resp = GetUserList(success: "", data: null, message: "", error: "", links: null, count: null);
    }

    return resp;
  }

}



class ReadUserController extends GetxController {

  late AdminClient _client;
  late ReadUserProvider _userRead;

  @override
  void onInit() {
    _client = AdminClient();
    _userRead = ReadUserProvider(_client.init());
    super.onInit();
  }

  final accessCtrl = Get.find<LoginController>();
  final TextEditingController filterCtrl = TextEditingController();
  var isGettingUsers = false.obs;
  var gotUserList = false.obs;
  var nbrOfUsers = 0.obs;
  late int gotUsers;
  List<GetUserData>? fullUsersList = [];
  var displayUserList = <UserListTable> [].obs;
  var cachedUserList = <UserListTable> [].obs;
  var sortColumnIndex = 0.obs;
  var sort = false.obs;


  var getUserListResponse =
      GetUserList(success: "", data: null, message: "", error: "", links: null, count: null).obs;

  Future<List<GetUserData>?> initUserList() async {

    fullUsersList?.clear();
    isGettingUsers.value = true;
    gotUsers = 0;
    int page = 1;

    do {
      try {
        getUserListResponse.value = (await _userRead.getUserList(page))!;
        debugPrint("check value getUserListResponse: ${getUserListResponse.value.data}");
        fullUsersList?.addAll(getUserListResponse.value.data as Iterable<GetUserData>);
        if(gotUsers == 0) {
          nbrOfUsers.value = getUserListResponse.value.count!;
          gotUsers += getUserListResponse.value.data!.length;
        } else {
          gotUsers += getUserListResponse.value.data!.length;
        }
      } catch (err) {
        isGettingUsers.value = false;
        debugPrint("error#7 $err");
        // in case of message of error is 'Expired Signature' then call tokenRefresh and retry
        if(getUserListResponse.value.message == 'Expired Signature') {
          accessCtrl.tokenRefresh();
          _client.refreshOption();
          debugPrint('Access token just refreshed !');
        }
      }
      debugPrint('Got $gotUsers users out of total $nbrOfUsers !');
      page++;
    } while (nbrOfUsers > gotUsers);

    displayUserList.clear();
    displayUserList.value.addAll(fullUsersList!.map((e) => (
        UserListTable(
            id: e.id!,
            username: e.username!,
            email: e.email!,
            lastLogin: e.lastLogin!,
            avatar: e.avatar!
        ))).toList());
    // updateReadiness();
    cachedUserList.value = displayUserList.value;
    gotUserList.value = true;
    isGettingUsers.value = false;
    return fullUsersList;
  }


  clearFilter() {
    filterCtrl.clear();
    displayUserList.value = cachedUserList.value
        .where((element) => element.username.toLowerCase().contains(''))
        .toList();
    sortColumnIndex.value = sortColumnIndex.value;
    sort.value = false;
  }

  filterUserTable(String value) {
    displayUserList.value = cachedUserList.value
        .where((element) => element.username.toLowerCase().contains(value))
        .toList();
  }
}