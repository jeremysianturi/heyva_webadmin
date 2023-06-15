import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as milliseconds;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../../../constant/variables.dart';
import '../../../../services/dio_services.dart';
import '../../login/controllers/login_controller.dart';
import './admin_api.dart';


class ReadProvider {
  final Dio _readClient;
  ReadProvider(this._readClient);

}

class ReadController extends GetxController {

  late AdminClient _client;
  late ReadProvider _read;

  @override
  void onInit() {
    _client = AdminClient();
    _read = ReadProvider(_client.init());
    super.onInit();
  }
  final accessCtrl = Get.find<LoginController>();
  final TextEditingController searchCtrl = TextEditingController();
  final TextEditingController titleCtrl = TextEditingController();
  final TextEditingController tagCtrl = TextEditingController();

}
